CREATE OR REPLACE PACKAGE FI_ASSET_CATEGORY_CG_G
AS

-- 내용년수 변경에 따른 시스템 추가 구축 -- 

--조회
PROCEDURE LIST_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
);









--신규자료 등록
PROCEDURE INS_ASSET_CATEGORY_CG( 
      P_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE               --회사아이디
    , P_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE  --자산유형코드      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --자산유형명칭
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --자산형태(1:유형자산, 2:무형자산)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --(IFRS)감가상각방법 1:정액,2:정율
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --(IFRS)내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --(IFRS)잔존가치
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --비고

    , P_CREATED_BY              IN FI_ASSET_CATEGORY_CG.CREATED_BY%TYPE            --생성자
);










--수정
PROCEDURE UPD_ASSET_CATEGORY_CG( 
      W_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --회사아이디
    , W_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --자산구분코드
      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --자산구분명칭
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --자산형태(1:유형자산, 2:무형자산)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --IFRS_감가상각방법 1:정액,2:정율
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --IFRS_내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --IFRS_잔존가치
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --비고

    , P_LAST_UPDATED_BY         IN FI_ASSET_CATEGORY_CG.LAST_UPDATED_BY%TYPE       --최종수정자
);








--삭제
PROCEDURE DEL_ASSET_CATEGORY_CG(
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --회사아이디
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --자산구분코드
);







--자산유형 POPUP
PROCEDURE POPUP_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
);






--자산유형명 반환
FUNCTION  F_ASSET_CATEGORY_NAME( 
    W_ASSET_CATEGORY_ID   IN   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_ID%TYPE
) RETURN VARCHAR2;



END FI_ASSET_CATEGORY_CG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_CATEGORY_CG_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_CATEGORY_CG_G
/* Description  : (변경)고정자산 카테고리 관리.
/*
/* Reference by :
/* Program History :
-- 내용년수 변경에 따른 시스템 추가 구축 -- 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 2013-10-21  Jeon Ho Su          Initialize
/******************************************************************************/

--조회
PROCEDURE LIST_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	            --회사아이디
        , ASSET_CATEGORY_ID	    --자산유형아이디
        , ASSET_CATEGORY_CODE	--자산유형코드
        , ASSET_CATEGORY_NAME	--자산유형명칭
        , (
            SELECT COUNT(*)
            FROM FI_ASSET_MASTER
            WHERE SOB_ID = W_SOB_ID
                AND ASSET_CATEGORY_ID = A.ASSET_CATEGORY_ID
          ) AS ASSET_CNT    --자산등록건수
        , ASSET_TYPE        --자산형태_코드(1:유형자산, 2:무형자산)
        , FI_COMMON_G.CODE_NAME_F('ASSET_TYPE', ASSET_TYPE, SOB_ID, NULL) AS ASSET_TYPE_NM  --자산형태_명
        , IFRS_DPR_METHOD_TYPE	--IFRS_감가상각방법_코드(1:정액,2:정율)
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', IFRS_DPR_METHOD_TYPE, SOB_ID, NULL) AS IFRS_DPR_METHOD_TYPE_NM --감가상각방법
        , IFRS_PROGRESS_YEAR	--IFRS_내용년수
        , IFRS_RESIDUAL_AMOUNT	--IFRS 잔존가치
        , REMARK                --비고
    FROM FI_ASSET_CATEGORY_CG A
    WHERE SOB_ID = W_SOB_ID
    ORDER BY ASSET_CATEGORY_CODE    ;

END LIST_ASSET_CATEGORY_CG;









--신규자료 등록
PROCEDURE INS_ASSET_CATEGORY_CG( 
      P_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE               --회사아이디
    , P_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE  --자산유형코드      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --자산유형명칭
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --자산형태(1:유형자산, 2:무형자산)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --(IFRS)감가상각방법 1:정액,2:정율
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --(IFRS)내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --(IFRS)잔존가치
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --비고

    , P_CREATED_BY              IN FI_ASSET_CATEGORY_CG.CREATED_BY%TYPE            --생성자
)

AS

V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
t_CNT NUMBER := 0;

BEGIN

    --동일자료 존재 유무 파악(KEY 중복 여부 파악)    
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_CATEGORY_CG
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_CATEGORY_CODE = P_ASSET_CATEGORY_CODE ;

    
    IF t_CNT > 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;


    INSERT INTO FI_ASSET_CATEGORY_CG( 
          ASSET_CATEGORY_ID --자산구분아이디
        , ASSET_CATEGORY_CODE   --자산구분코드
        , ASSET_CATEGORY_NAME   --자산구분명칭
        , SOB_ID                --회사아이디
        , ASSET_TYPE            --자산형태(1:유형자산, 2:무형자산)
        , IFRS_DPR_METHOD_TYPE  --IFRS_감가상각방법 1:정액,2:정율
        , IFRS_PROGRESS_YEAR    --IFRS_내용년수
        , IFRS_RESIDUAL_AMOUNT  --IFRS_잔존가치
        , REMARK                --비고
        , CREATION_DATE         --생성일자
        , CREATED_BY            --생성자
        , LAST_UPDATE_DATE      --최종수정일자
        , LAST_UPDATED_BY       --최종수정자 
    )
    VALUES
    ( 
          (SELECT NVL(MAX(ASSET_CATEGORY_ID), 0) + 1 FROM FI_ASSET_CATEGORY_CG)    --자산구분아이디
        , P_ASSET_CATEGORY_CODE     --자산구분코드
        , P_ASSET_CATEGORY_NAME     --자산구분명칭
        , P_SOB_ID                  --회사아이디
        , P_ASSET_TYPE              --자산형태(1:유형자산, 2:무형자산)
        , P_IFRS_DPR_METHOD_TYPE    --IFRS_감가상각방법 1:정액,2:정율
        , P_IFRS_PROGRESS_YEAR      --IFRS_내용년수
        , P_IFRS_RESIDUAL_AMOUNT    --IFRS_잔존가치
        , P_REMARK                  --비고
        , GET_LOCAL_DATE(P_SOB_ID)  --생성일자
        , P_CREATED_BY              --생성자
        , GET_LOCAL_DATE(P_SOB_ID)  --최종수정일자
        , P_CREATED_BY              --최종수정자 
    );

EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);

END INS_ASSET_CATEGORY_CG;










--수정
PROCEDURE UPD_ASSET_CATEGORY_CG( 
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --회사아이디
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --자산구분코드
      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --자산구분명칭
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --자산형태(1:유형자산, 2:무형자산)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --IFRS_감가상각방법 1:정액,2:정율
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --IFRS_내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --IFRS_잔존가치
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --비고    

    , P_LAST_UPDATED_BY         IN FI_ASSET_CATEGORY_CG.LAST_UPDATED_BY%TYPE       --최종수정자
)

AS

BEGIN

    UPDATE FI_ASSET_CATEGORY_CG
    SET
          ASSET_CATEGORY_NAME   = P_ASSET_CATEGORY_NAME     --자산구분명칭
        , ASSET_TYPE            = P_ASSET_TYPE              --자산형태       
        , IFRS_DPR_METHOD_TYPE  = P_IFRS_DPR_METHOD_TYPE    --IFRS_감가상각방법
        , IFRS_PROGRESS_YEAR    = P_IFRS_PROGRESS_YEAR      --IFRS_내용년수
        , IFRS_RESIDUAL_AMOUNT  = P_IFRS_RESIDUAL_AMOUNT    --IFRS_잔존가치     
        , REMARK                = P_REMARK                  --비고
        
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(SOB_ID)    --최종수정일자
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --최종수정자
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE ;

END UPD_ASSET_CATEGORY_CG;









--삭제
PROCEDURE DEL_ASSET_CATEGORY_CG(
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --회사아이디
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --자산구분코드
)

AS

t_CNT   NUMBER := 0;
Key_Dup EXCEPTION;

BEGIN

    --해당 자산유형으로 등록된 자산이 있는지를 파악한다.        
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_ID =
                (
                    SELECT ASSET_CATEGORY_ID
                    FROM FI_ASSET_CATEGORY_CG  
                    WHERE SOB_ID = W_SOB_ID
                        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE
                )   ;        
       
    IF t_CNT > 0 THEN
      RAISE Key_Dup;
    END IF;    


    --해당 자산유형으로 등록된 자산이 없으면 삭제한다.
    DELETE FI_ASSET_CATEGORY_CG
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE ;
        
        
EXCEPTION
    WHEN Key_Dup THEN
        --FCM_10307, 기준자료로 삭제할 수 없습니다.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10307', NULL));

END DEL_ASSET_CATEGORY_CG;









--자산유형 POPUP
PROCEDURE POPUP_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT 
          ASSET_CATEGORY_NAME   --자산유형명칭
        , ASSET_CATEGORY_CODE   --자산유형코드
        , ASSET_CATEGORY_ID     --자산유형아이디
        , IFRS_DPR_METHOD_TYPE	--IFRS_감가상각방법_코드 (1:정액,2:정율)
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', IFRS_DPR_METHOD_TYPE, SOB_ID, NULL) AS IFRS_DPR_METHOD_TYPE_NM --감가상각방법    
        , IFRS_PROGRESS_YEAR	--IFRS_내용년수
        , IFRS_RESIDUAL_AMOUNT	--IFRS 잔존가치         
    FROM FI_ASSET_CATEGORY_CG
    WHERE SOB_ID              = W_SOB_ID
    ORDER BY ASSET_CATEGORY_CODE    ;

END POPUP_ASSET_CATEGORY_CG;








--자산유형명 반환
FUNCTION  F_ASSET_CATEGORY_NAME( 
    W_ASSET_CATEGORY_ID   IN   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_ID%TYPE
) RETURN VARCHAR2

AS

t_ASSET_CATEGORY_NAME   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE := '';

BEGIN

    SELECT ASSET_CATEGORY_NAME
    INTO t_ASSET_CATEGORY_NAME
    FROM FI_ASSET_CATEGORY_CG
    WHERE ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID   ;

RETURN t_ASSET_CATEGORY_NAME;

END F_ASSET_CATEGORY_NAME   ;


END FI_ASSET_CATEGORY_CG_G;
/
