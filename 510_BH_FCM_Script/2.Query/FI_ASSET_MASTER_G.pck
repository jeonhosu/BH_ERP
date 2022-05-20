CREATE OR REPLACE PACKAGE FI_ASSET_MASTER_G
AS

-- 자산대장 조회.
  PROCEDURE SELECT_ASSET_MASTER
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_ID             IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_ASSET_STATUS_CODE    IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );

-- 자산대장 삽입.
PROCEDURE INSERT_ASSET_MASTER
          ( P_ASSET_ID                 OUT FI_ASSET_MASTER.ASSET_ID%TYPE
          , P_ASSET_CODE               IN FI_ASSET_MASTER.ASSET_CODE%TYPE
          , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
          , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
          , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
          , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
          , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
          , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
          , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
          , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
          , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
          , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
          , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
          , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
          , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
          , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
          , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
          , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
          , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
          , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
          , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
          , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
          , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
          , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
          , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
          , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
          , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
          , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
          , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
          , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
          , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
          , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
          , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
          , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
          , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
          , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE
          );

-- 자산대장 수정.
  PROCEDURE UPDATE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
            , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
            , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
            , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
            , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
            , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
            , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
            , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
            , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
            , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
            , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
            , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
            , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
            , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
            , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
            , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
            , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
            , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
            , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
            , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
            , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
            , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
            , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
            , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE 
            );

-- 자산대장 삭제.
  PROCEDURE DELETE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 자산코드 LOOKUP 조회.
  PROCEDURE LU_ASSET_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );

-- 자산코드 LOOKUP 조회.
  PROCEDURE LU_ASSET_CODE_FR_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ASSET_CODE           IN FI_ASSET_MASTER.ASSET_CODE%TYPE
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE DEFAULT NULL
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );
            
-- 자산CATEGORY LOOKUP 조회.
  PROCEDURE LU_ASSET_CATEGORY
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            );
            
            
            








            
--하기 부터가 임동언이 개발한 내용이다.(2011.10.18)


--조회
PROCEDURE LIST_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE             --회사아이디
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE  --자산유형아이디
    , W_ASSET_CODE          IN  FI_ASSET_MASTER.ASSET_CODE%TYPE         --자산코드
    , W_ASSET_STATUS_CODE   IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE  --자산상태
);






--자산대장 신규자료 등록
PROCEDURE INS_ASSET_MASTER( 
      P_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE                 --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_MASTER.ORG_ID%TYPE                 --사업부아이디     
    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE      --자산유형아이디
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE             --자산명
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --취득일자
    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --등록일자
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --취득금액 
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --경비구분
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --원가아이디
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE                    --수량
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE                --용도
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE              --거래처아이디
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE         --관리부서아이디
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE                 --비고
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE   --(IFRS)감가상각방법
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)잔존가액
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)상각상태
    
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --자산상태

    , P_CREATED_BY              IN  FI_ASSET_MASTER.CREATED_BY%TYPE             --생성자 
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- 사업장코드. 
);




--감가상각스케쥴 생성
PROCEDURE CREATE_ASSET_DPR_HISTORY( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --사업부아이디

    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_DPR_HISTORY.ASSET_CATEGORY_ID%TYPE --자산유형아이디
    , P_ASSET_ID                IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE          --자산아이디
    , P_DPR_METHOD_TYPE         IN  FI_ASSET_DPR_HISTORY.DPR_METHOD_TYPE%TYPE   --감가상각방법_코드
    , P_COST_CENTER_ID          IN  FI_ASSET_DPR_HISTORY.COST_CENTER_ID%TYPE    --원가아이디

    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --취득일자 
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)내용년수
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --취득금액 
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)잔존가액    
    
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --생성자 
);








--이 PROCEDURE는 가 등록된 자산의 감가상각스케쥴 생성을 위한 임시성 PROCEDURE로 
--지금 시점(2011.10.24) 외에는 사용되지 않는 것이다.
PROCEDURE CREATE_BATCH_DPR( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --사업부아이디       
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --생성자 
);









--자산대장 수정
PROCEDURE UPD_ASSET_MASTER( 
      W_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE         --회사아이디
    , W_ASSET_CODE              IN  FI_ASSET_MASTER.ASSET_CODE%TYPE     --자산코드
      
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE     --자산명     
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE            --수량
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE        --용도
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE      --거래처아이디
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE --관리부서아이디
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE --비고

    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --등록일자       
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --경비구분
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --원가아이디
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --자산상태
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)상각상태          

    , P_LAST_UPDATED_BY         IN  FI_ASSET_MASTER.LAST_UPDATED_BY%TYPE    --최종수정자
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- 사업장코드.
);



      


--자산대장 삭제
PROCEDURE DEL_ASSET_MASTER(
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --회사아이디
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_CODE%TYPE --자산아이디
);








--자산변동내역 조회
PROCEDURE LIST_ASSET_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_HISTORY.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID      IN  FI_ASSET_HISTORY.ORG_ID%TYPE    --사업부어이디
    , W_ASSET_ID    IN  FI_ASSET_HISTORY.ASSET_ID%TYPE  --자산아이디
);







--자산변동내역 신규자료 등록
PROCEDURE INS_ASSET_HISTORY( 
      P_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디    
    , P_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자
    , P_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE         --변경사유_아이디
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --(변동후)원가아이디
    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(변동후)수량  
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --관리부서_아이디
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --비고    
    
    , P_CREATED_BY      IN  FI_ASSET_HISTORY.CREATED_BY%TYPE        --생성자 
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- 사업장코드 
);






--자본적지출에 따른 추가상각액 설정 및 감가상각누계액과 미상각잔액 금액 변경
PROCEDURE CHG_ASSET_DPR_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자        
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액; 추가되는 감가상각대상금액이다.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
);








--부분매각에 따른 차감상각액 설정 및 감가상각누계액과 미상각잔액 금액 변경
PROCEDURE CHG_ASSET_DPR_HISTORY_PART( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자        
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액; 차감되는 감가상각대상금액이다.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
);






--자본변동내역 등록 시 [단, 자본적지출, 부분매각 제외]
--FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 해당 자산의 원가아이디 변경
--감가상각방법(1:정액법, 2:정율법)이 뭐든간에 관계없다. 동일하게 적용된다.
PROCEDURE UPD_ASSET_DPR_HISTORY_COST( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자       
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
);







--자산변동내역 수정
PROCEDURE UPD_ASSET_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디 
    , W_HISTORY_NUM     IN  FI_ASSET_HISTORY.HISTORY_NUM%TYPE       --자산변동번호         

    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(변동후)수량       
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --비고
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --관리부서_아이디

    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- 사업장코드
);







--자산별 감가상각스케쥴 조회
PROCEDURE LIST_ASSET_DPR_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE    --사업부어이디
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE  --자산아이디
    --, W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE  --회계구분
);






--자산명 반환
FUNCTION  F_ASSET_DESC( 
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID      IN  FI_ASSET_MASTER.ORG_ID%TYPE     --사업부아이디
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_ID%TYPE   --자산아이디
) RETURN VARCHAR2;








--자산명 선택 POPUP
PROCEDURE POPUP_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
);







--자산변동내역 PG의 자산변동내역 조회
--참조>LIST_ASSET_HISTORY PROCEDURE와 동일하다.
PROCEDURE LIST_ASSET_HISTORY_ALL( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE        --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE        --사업부어이디    
    , W_CHARGE_DATE_FR  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --변경일자_시작
    , W_CHARGE_DATE_TO  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --변경일자_종료
    , W_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE     --변경사유아이디
);



            
END FI_ASSET_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_MASTER_G
/* Description  : 고정자산 마스터.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 자산대장 조회.
  PROCEDURE SELECT_ASSET_MASTER
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_ID             IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_ASSET_STATUS_CODE    IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AM.ASSET_ID
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , AM.ASSET_CATEGORY_ID
           , FAC.ASSET_CATEGORY_NAME
           , AM.EXPENSE_TYPE
           , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID) AS EXPENSE_TYPE_NAME
           , AM.SPEC
           , AM.PURPOSE
           , AM.ACQUIRE_DATE
           , AM.REGISTER_DATE
           , AM.LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AM.LOCATION_ID) AS LOCATION_NAME
           , AM.LOCATION_DESC
           , AM.QTY
           , AM.UOM_CODE
           , AM.UNIT_PRICE
           , AM.CURRENCY_CODE
           , AM.EXCHANGE_RATE
           , AM.CURR_AMOUNT
           , AM.AMOUNT           
           , AM.DPR_YN
           , AM.DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.DPR_METHOD_TYPE, AM.SOB_ID) AS DPR_METHOD_NAME
           , AM.DPR_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('10', AM.DPR_METHOD_TYPE, AM.SOB_ID, AM.DPR_PROGRESS_YEAR) AS DPR_RATE
           , AM.RESIDUAL_AMOUNT
           , AM.DPR_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', AM.DPR_STATUS_CODE, AM.SOB_ID) AS DPR_STATUS_NAME
           , AM.DPR_SUM_CURR_AMOUNT
           , AM.DPR_SUM_AMOUNT
           , NVL(AM.AMOUNT, 0) - NVL(AM.DPR_SUM_AMOUNT, 0) AS DPR_REMAIN_AMOUNT
           , AM.DPR_LAST_PERIOD
           , AM.IFRS_DPR_YN
           , AM.IFRS_DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.IFRS_DPR_METHOD_TYPE, AM.SOB_ID) AS IFRS_DPR_METHOD_NAME
           , AM.IFRS_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('20', AM.IFRS_DPR_METHOD_TYPE, AM.SOB_ID, AM.IFRS_PROGRESS_YEAR) AS IFRS_DPR_RATE
           , AM.IFRS_RESIDUAL_AMOUNT
           , AM.IFRS_DPR_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', AM.IFRS_DPR_STATUS_CODE, AM.SOB_ID) AS IFRS_DPR_STATUS_NAME
           , AM.IFRS_DPR_SUM_CURR_AMOUNT
           , AM.IFRS_DPR_SUM_AMOUNT
           , NVL(AM.AMOUNT, 0) - NVL(AM.IFRS_DPR_SUM_AMOUNT, 0) AS IFRS_DPR_REMAIN_AMOUNT
           , AM.IFRS_DPR_LAST_PERIOD
           , AM.VENDOR_ID
           , SC.SUPP_CUST_NAME AS VENDOR_NAME
           , AM.MANAGE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AM.MANAGE_DEPT_ID) AS MANAGE_DEPT_NAME
           , AM.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID) AS CC_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID) AS CC_DESC
           , AM.ASSET_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', AM.ASSET_STATUS_CODE, AM.SOB_ID) AS ASSET_STATUS_NAME
           , AM.DISUSE_DATE
           , AM.REMARK
           , NVL(SX1.CE_AMOUNT, 0) AS CE_AMOUNT
        FROM FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY FAC
          , FI_SUPP_CUST_V SC
          , ( -- 자본적 지출 금액.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(AH.AMOUNT), 0) AS CE_AMOUNT
              FROM FI_ASSET_HISTORY AH
            WHERE AH.ASSET_ID                 = NVL(W_ASSET_ID, AH.ASSET_ID)
              AND AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        = '10'
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX1     
      WHERE AM.ASSET_CATEGORY_ID        = FAC.ASSET_CATEGORY_ID
        AND AM.VENDOR_ID                = SC.SUPP_CUST_ID(+)
        AND AM.ASSET_ID                 = SX1.ASSET_ID(+)
        AND AM.SOB_ID                   = SX1.SOB_ID(+)
        AND AM.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
        AND AM.ASSET_ID                 = NVL(W_ASSET_ID, AM.ASSET_ID)
        AND AM.ASSET_STATUS_CODE        = NVL(W_ASSET_STATUS_CODE, AM.ASSET_STATUS_CODE)
        AND AM.SOB_ID                   = W_SOB_ID
      ORDER BY AM.ASSET_CODE
      ;

  END SELECT_ASSET_MASTER;

-- 자산대장 삽입.
PROCEDURE INSERT_ASSET_MASTER
          ( P_ASSET_ID                 OUT FI_ASSET_MASTER.ASSET_ID%TYPE
          , P_ASSET_CODE               IN FI_ASSET_MASTER.ASSET_CODE%TYPE
          , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
          , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
          , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
          , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
          , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
          , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
          , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
          , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
          , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
          , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
          , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
          , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
          , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
          , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
          , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
          , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
          , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
          , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
          , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
          , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
          , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
          , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
          , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
          , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
          , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
          , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
          , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
          , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
          , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
          , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
          , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
          , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
          , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
          , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE
          )
  AS
    V_SYSDATE                          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ASSET_CATEGORY_CODE              VARCHAR2(10);
    V_DPR_STATUS_CODE                  VARCHAR2(10) := NULL;
    V_IFRS_DPR_STATUS_CODE             VARCHAR2(10) := NULL;
    
  BEGIN
    BEGIN
      SELECT AC.ASSET_CATEGORY_CODE
        INTO V_ASSET_CATEGORY_CODE
        FROM FI_ASSET_CATEGORY AC
      WHERE AC.ASSET_CATEGORY_ID  = P_ASSET_CATEGORY_ID
        AND AC.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    -- 감가 상태 표시.
    IF P_DPR_YN = 'Y' THEN
      V_DPR_STATUS_CODE := '10';
    END IF;
    IF P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := '10';    
    END IF;
    
    SELECT FI_ASSET_MASTER_S1.NEXTVAL
      INTO P_ASSET_ID
      FROM DUAL;
    
    --P_ASSET_CODE := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('DP', P_SOB_ID, P_REGISTER_DATE, P_USER_ID);
    
    INSERT INTO FI_ASSET_MASTER
    ( ASSET_ID
    , ASSET_CODE 
    , ASSET_DESC 
    , SOB_ID 
    , ORG_ID 
    , EXPENSE_TYPE
    , ASSET_CATEGORY_ID 
    , SPEC 
    , PURPOSE 
    , ACQUIRE_DATE 
    , REGISTER_DATE 
    , LOCATION_ID 
    , LOCATION_DESC 
    , QTY 
    , UOM_CODE 
    , INVEST_ID 
    , UNIT_PRICE 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , CURR_AMOUNT 
    , AMOUNT     
    , DPR_YN 
    , DPR_METHOD_TYPE 
    , DPR_PROGRESS_YEAR
    , RESIDUAL_AMOUNT
    , DPR_STATUS_CODE
    , IFRS_DPR_YN 
    , IFRS_DPR_METHOD_TYPE 
    , IFRS_PROGRESS_YEAR
    , IFRS_RESIDUAL_AMOUNT    
    , IFRS_DPR_STATUS_CODE
    , VENDOR_ID 
    , MANAGE_DEPT_ID 
    , COST_CENTER_ID 
    , ASSET_STATUS_CODE
    , DISUSE_DATE
    , REMARK 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ASSET_ID
    , P_ASSET_CODE
    , P_ASSET_DESC
    , P_SOB_ID
    , P_ORG_ID
    , P_EXPENSE_TYPE
    , P_ASSET_CATEGORY_ID
    , P_SPEC
    , P_PURPOSE
    , P_ACQUIRE_DATE
    , P_REGISTER_DATE
    , P_LOCATION_ID
    , P_LOCATION_DESC
    , P_QTY
    , P_UOM_CODE
    , P_INVEST_ID
    , P_UNIT_PRICE
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_CURR_AMOUNT
    , P_AMOUNT
    , P_DPR_YN
    , P_DPR_METHOD_TYPE
    , P_DPR_PROGRESS_YEAR
    , P_RESIDUAL_AMOUNT
    , V_DPR_STATUS_CODE
    , P_IFRS_DPR_YN
    , P_IFRS_DPR_METHOD_TYPE
    , P_IFRS_PROGRESS_YEAR
    , P_IFRS_RESIDUAL_AMOUNT
    , V_IFRS_DPR_STATUS_CODE
    , P_VENDOR_ID
    , P_MANAGE_DEPT_ID
    , P_COST_CENTER_ID
    , P_ASSET_STATUS_CODE
    , P_DISUSE_DATE
    , P_REMARK
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_ASSET_MASTER;

-- 자산대장 수정.
  PROCEDURE UPDATE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
            , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
            , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
            , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
            , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
            , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
            , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
            , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
            , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
            , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
            , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
            , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
            , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
            , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
            , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
            , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
            , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
            , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
            , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
            , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
            , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
            , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
            , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
            , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_DPR_STATUS_CODE                  VARCHAR2(10) := NULL;
    V_IFRS_DPR_STATUS_CODE             VARCHAR2(10) := NULL;
    
  BEGIN
    BEGIN
      SELECT AM.DPR_STATUS_CODE
           , AM.IFRS_DPR_STATUS_CODE
        INTO V_DPR_STATUS_CODE
           , V_IFRS_DPR_STATUS_CODE
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID         = W_ASSET_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- 감가 상태 표시.
    IF V_DPR_STATUS_CODE IS NULL AND P_DPR_YN = 'Y' THEN
      V_DPR_STATUS_CODE := '10';
    ELSIF V_DPR_STATUS_CODE IS NULL AND P_DPR_YN = 'N' THEN
      V_DPR_STATUS_CODE := NULL;
    END IF;
    IF V_IFRS_DPR_STATUS_CODE IS NULL AND P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := '10';    
    ELSIF V_IFRS_DPR_STATUS_CODE IS NULL AND P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := NULL;
    END IF;
    
    UPDATE FI_ASSET_MASTER
      SET ASSET_DESC               = P_ASSET_DESC
        , EXPENSE_TYPE             = P_EXPENSE_TYPE
        , ASSET_CATEGORY_ID        = P_ASSET_CATEGORY_ID
        , SPEC                     = P_SPEC
        , PURPOSE                  = P_PURPOSE
        , ACQUIRE_DATE             = P_ACQUIRE_DATE
        , REGISTER_DATE            = P_REGISTER_DATE
        , LOCATION_ID              = P_LOCATION_ID
        , LOCATION_DESC            = P_LOCATION_DESC
        , QTY                      = P_QTY
        , UOM_CODE                 = P_UOM_CODE
        , INVEST_ID                = P_INVEST_ID
        , UNIT_PRICE               = P_UNIT_PRICE
        , CURRENCY_CODE            = P_CURRENCY_CODE
        , EXCHANGE_RATE            = P_EXCHANGE_RATE
        , CURR_AMOUNT              = P_CURR_AMOUNT
        , AMOUNT                   = P_AMOUNT        
        , DPR_YN                   = P_DPR_YN
        , DPR_METHOD_TYPE          = P_DPR_METHOD_TYPE
        , DPR_PROGRESS_YEAR        = P_DPR_PROGRESS_YEAR
        , RESIDUAL_AMOUNT          = P_RESIDUAL_AMOUNT
        , DPR_STATUS_CODE          = V_DPR_STATUS_CODE
        , IFRS_DPR_YN              = P_IFRS_DPR_YN
        , IFRS_DPR_METHOD_TYPE     = P_IFRS_DPR_METHOD_TYPE
        , IFRS_PROGRESS_YEAR       = P_IFRS_PROGRESS_YEAR
        , IFRS_RESIDUAL_AMOUNT     = P_IFRS_RESIDUAL_AMOUNT
        , IFRS_DPR_STATUS_CODE     = V_IFRS_DPR_STATUS_CODE
        , VENDOR_ID                = P_VENDOR_ID
        , MANAGE_DEPT_ID           = P_MANAGE_DEPT_ID
        , COST_CENTER_ID           = P_COST_CENTER_ID
        , ASSET_STATUS_CODE        = P_ASSET_STATUS_CODE
        , DISUSE_DATE              = P_DISUSE_DATE
        , REMARK                   = P_REMARK
        , LAST_UPDATE_DATE         = V_SYSDATE
        , LAST_UPDATED_BY          = P_USER_ID
    WHERE ASSET_ID                 = W_ASSET_ID;

  END UPDATE_ASSET_MASTER;

-- 자산대장 삭제.
  PROCEDURE DELETE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM FI_ASSET_MASTER
    WHERE ASSET_ID                 = W_ASSET_ID;
  END DELETE_ASSET_MASTER;
  
---------------------------------------------------------------------------------------------------
-- 자산코드 LOOKUP 조회.
  PROCEDURE LU_ASSET_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT AM.ASSET_DESC
           , AM.ASSET_CODE
           , AM.ASSET_ID
        FROM FI_ASSET_MASTER AM
      WHERE AM.SOB_ID              = W_SOB_ID
      ORDER BY AM.ASSET_CODE
      ;

  END LU_ASSET_CODE;




--자산코드 LOOKUP 조회.
PROCEDURE LU_ASSET_CODE_FR_TO
        ( P_CURSOR3              OUT TYPES.TCURSOR3
        , W_ASSET_CODE           IN FI_ASSET_MASTER.ASSET_CODE%TYPE
        , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE DEFAULT NULL
        , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
        )
AS
BEGIN
OPEN P_CURSOR3 FOR
  SELECT AM.ASSET_DESC
       , AM.ASSET_CODE
       , AM.ASSET_ID
    FROM FI_ASSET_MASTER AM
  WHERE AM.ASSET_CODE         >= NVL(W_ASSET_CODE, AM.ASSET_CODE)
    AND AM.ASSET_CATEGORY_ID  = NVL(W_ASSET_CATEGORY_ID, AM.ASSET_CATEGORY_ID)
    AND AM.SOB_ID             = W_SOB_ID
  ORDER BY AM.ASSET_CODE
  ;
END LU_ASSET_CODE_FR_TO;





-- 자산CATEGORY LOOKUP 조회.
  PROCEDURE LU_ASSET_CATEGORY
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT AC.ASSET_CATEGORY_NAME
           , AC.ASSET_CATEGORY_CODE
           , AC.ASSET_CATEGORY_ID
           , AC.DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AC.DPR_METHOD_TYPE, AC.SOB_ID) AS DPR_METHOD_NAME
           , AC.PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('10', AC.DPR_METHOD_TYPE, AC.SOB_ID, AC.PROGRESS_YEAR) AS DPR_RATE
           , AC.RESIDUAL_AMOUNT
           , AC.IFRS_DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AC.IFRS_DPR_METHOD_TYPE, AC.SOB_ID) AS IFRS_DPR_METHOD_NAME
           , AC.IFRS_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('20', AC.IFRS_DPR_METHOD_TYPE, AC.SOB_ID, AC.IFRS_PROGRESS_YEAR) AS IFRS_DPR_RATE
           , AC.IFRS_RESIDUAL_AMOUNT
        FROM FI_ASSET_CATEGORY AC
       WHERE AC.SOB_ID              = W_SOB_ID
         AND AC.ENABLED_FLAG        = DECODE(W_ENABLED_YN, 'Y', 'Y', AC.ENABLED_FLAG)
         AND AC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_FR)
         AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_TO))
      ORDER BY AC.ASSET_CATEGORY_CODE
      ;  
  
  END LU_ASSET_CATEGORY;









--하기 부터가 임동언이 개발한 내용이다.(2011.10.18)




--조회
PROCEDURE LIST_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE             --회사아이디
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE  --자산유형아이디
    , W_ASSET_CODE          IN  FI_ASSET_MASTER.ASSET_CODE%TYPE         --자산코드
    , W_ASSET_STATUS_CODE   IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE  --자산상태
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
         A.SOB_ID               --회사아이디
       , A.ORG_ID               --사업부아이디
       , A.ASSET_CATEGORY_ID    --자산유형아이디
       , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY   --자산유형
       , A.ASSET_ID           --자산아이디
       , A.ASSET_CODE         --자산코드
       , A.ASSET_DESC         --자산명
       , A.ASSET_STATUS_CODE  --자산상태
       , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', A.ASSET_STATUS_CODE, A.SOB_ID) AS ASSET_STATUS_NM  --자산상태
       , A.ACQUIRE_DATE   --취득일자
       , A.REGISTER_DATE  --등록일자
       , A.DISUSE_DATE    --폐기(매각)일자   
       , A.AMOUNT         --취득금액 

       --전표등록여부에 따라 삭제 가능여부를 판단한다.
       , CASE
            WHEN NVL(B.CNT, 0) > 0 THEN 'Y'
            ELSE 'N'
         END SLIP_REG_YN
            
        --자산변동여부
        , (SELECT
            CASE
                WHEN COUNT(*) > 0 THEN 'Y'
                ELSE 'N'
            END
            FROM FI_ASSET_HISTORY
            WHERE SOB_ID = A.SOB_ID
                AND ORG_ID = A.ORG_ID
                AND ASSET_ID = A.ASSET_ID    ) AS ASSET_CHANGE_YN            
       
       , A.EXPENSE_TYPE   --경비구분
       , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --경비구분
       , A.COST_CENTER_ID --원가아이디
       , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
       , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명
       
       , A.QTY        --수량
       , A.PURPOSE    --용도
       , A.VENDOR_ID  --거래처아이디
       , FI_COMMON_G.SUPP_CUST_ID_NAME_F(A.VENDOR_ID) AS VENDOR_NM   --거래처
       , A.MANAGE_DEPT_ID --관리부서아이디
       , FI_DEPT_MASTER_G.DEPT_NAME_F(A.MANAGE_DEPT_ID) AS MANAGE_DEPT_NM --관리부서
       , REMARK --비고

       , A.IFRS_DPR_YN            --(IFRS)상각여부 [N:미상각,Y:상각] ; INSERT시 기본으로 'Y'로 설정한다.
       , A.IFRS_DPR_METHOD_TYPE   --(IFRS)감가상각방법
       , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.IFRS_DPR_METHOD_TYPE, A.SOB_ID) AS IFRS_DPR_METHOD_NM --(IFRS)감가상각방법
       , A.IFRS_PROGRESS_YEAR --(IFRS)내용년수
       , A.IFRS_RESIDUAL_AMOUNT   --(IFRS)잔존가액
       , A.IFRS_DPR_STATUS_CODE   --(IFRS)상각상태
       , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', A.IFRS_DPR_STATUS_CODE, A.SOB_ID) AS IFRS_DPR_STATUS_NM  --(IFRS)상각상태
       , 0 AS IFRS_DPR_SUM_AMOUNT    --(IFRS)상각누계액
       , 0 AS IFRS_DPR_REMAIN_AMOUNT --(IFRS)미상각잔액
       
       -- 2013.06.06 전호수 추가 : 사업장 정보 --       
       , A.TAX_CODE
       , FI_COMMON_G.CODE_NAME_F('TAX_CODE', A.TAX_CODE, A.SOB_ID, A.ORG_ID) AS TAX_DESC
       
       --, LOCATION_ID    --자산위치_아이디
       --, FI_COMMON_G.ID_NAME_F(LOCATION_ID) AS LOCATION_NM    --자산위치  
       --, IFRS_DPR_LAST_PERIOD   --(IFRS)최종상각년월
       
    FROM FI_ASSET_MASTER A
        , (SELECT SOB_ID, ASSET_CATEGORY_ID, ASSET_ID, COUNT(*) AS CNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND DPR_TYPE = '20'
                AND SLIP_YN = 'Y'
            GROUP BY SOB_ID, ASSET_CATEGORY_ID, ASSET_ID) B    
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID --자산유형아이디
        AND A.ASSET_CODE = NVL(W_ASSET_CODE, A.ASSET_CODE)  --자산코드
        AND A.ASSET_STATUS_CODE = NVL(W_ASSET_STATUS_CODE, A.ASSET_STATUS_CODE) --자산상태

        AND A.SOB_ID = B.SOB_ID(+)
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID(+)
        AND A.ASSET_ID = B.ASSET_ID(+)
    ORDER BY A.ASSET_CODE ;

END LIST_ASSET_MASTER;








--자산대장 신규자료 등록
PROCEDURE INS_ASSET_MASTER( 
      P_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE                 --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_MASTER.ORG_ID%TYPE                 --사업부아이디     
    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE      --자산유형아이디
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE             --자산명
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --취득일자
    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --등록일자
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --취득금액 
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --경비구분
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --원가아이디
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE                    --수량
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE                --용도
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE              --거래처아이디
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE         --관리부서아이디
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE                 --비고
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE   --(IFRS)감가상각방법
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)내용년수
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)잔존가액
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)상각상태
    
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --자산상태    

    , P_CREATED_BY              IN  FI_ASSET_MASTER.CREATED_BY%TYPE             --생성자  
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- 사업장코드. 
)

AS

V_SYSDATE               DATE := GET_LOCAL_DATE(P_SOB_ID);
t_CNT                   NUMBER := 0;    --해당 자산유형아이디로 등록된 자산이 있는지 여부 파악
t_ASSET_CATEGORY_CODE   FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE := NULL; --자산유형코드
t_ASSET_CODE            FI_ASSET_MASTER.ASSET_CODE%TYPE := NULL;            --자산코드
t_ASSET_ID              FI_ASSET_MASTER.ASSET_ID%TYPE := NULL;              --자산아이디

BEGIN

     --해당 자산유형아이디로 등록된 자산이 있는지 여부 파악
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_MASTER
    WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;
    
    
    --자산코드 채번
    IF t_CNT = 0 THEN   --해당 자산유형아이디로 등록된 자산이 없는 경우
    
        --자산유형코드를 구한다.
        SELECT ASSET_CATEGORY_CODE
        INTO t_ASSET_CATEGORY_CODE
        FROM FI_ASSET_CATEGORY
        WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;

        SELECT t_ASSET_CATEGORY_CODE || '000000001'
        INTO t_ASSET_CODE
        FROM DUAL   ;
        
    ELSE       --해당 자산유형아이디로 등록된 자산이 있는 경우
        SELECT SUBSTR(MAX(ASSET_CODE), 1, 1) || LPAD(SUBSTR(MAX(ASSET_CODE), 2) + 1, 9, 0)
        INTO t_ASSET_CODE
        FROM FI_ASSET_MASTER
        WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;    
    END IF;
    
    
    
    --자산아이디
    SELECT NVL(MAX(ASSET_ID), 0) + 1 
    INTO t_ASSET_ID
    FROM FI_ASSET_MASTER    ;


    INSERT INTO FI_ASSET_MASTER( 
          SOB_ID                --회사아이디
        , ORG_ID                --사업부아이디     
        , ASSET_CATEGORY_ID     --자산유형아이디
        , ASSET_DESC            --자산명
        , ACQUIRE_DATE          --취득일자
        , REGISTER_DATE         --등록일자
        , AMOUNT                --취득금액 
        , EXPENSE_TYPE          --경비구분
        , COST_CENTER_ID        --원가아이디
        , QTY                   --수량
        , PURPOSE               --용도
        , VENDOR_ID             --거래처아이디
        , MANAGE_DEPT_ID        --관리부서아이디
        , REMARK                --비고
        , IFRS_DPR_METHOD_TYPE  --(IFRS)감가상각방법
        , IFRS_PROGRESS_YEAR    --(IFRS)내용년수
        , IFRS_RESIDUAL_AMOUNT  --(IFRS)잔존가액
        , IFRS_DPR_STATUS_CODE  --(IFRS)상각상태
        
        , ASSET_ID              --자산아이디
        , ASSET_CODE            --자산코드
        , ASSET_STATUS_CODE     --자산상태
        , IFRS_DPR_YN           --(IFRS)상각여부
        , DPR_METHOD_TYPE       --(K-GAAP)감가상각방법
        
        , CREATION_DATE         --생성일자
        , CREATED_BY            --생성자
        , LAST_UPDATE_DATE      --최종수정일자
        , LAST_UPDATED_BY       --최종수정자 
        , TAX_CODE              --사업장코드 
    )
    VALUES
    ( 
          P_SOB_ID                  --회사아이디
        , P_ORG_ID                  --사업부아이디     
        , P_ASSET_CATEGORY_ID       --자산유형아이디
        , P_ASSET_DESC              --자산명
        , P_ACQUIRE_DATE            --취득일자
        , P_REGISTER_DATE           --등록일자
        , P_AMOUNT                  --취득금액 
        , P_EXPENSE_TYPE            --경비구분
        , P_COST_CENTER_ID          --원가아이디
        , P_QTY                     --수량
        , P_PURPOSE                 --용도
        , P_VENDOR_ID               --거래처아이디
        , P_MANAGE_DEPT_ID          --관리부서아이디
        , P_REMARK                  --비고
        , P_IFRS_DPR_METHOD_TYPE    --(IFRS)감가상각방법
        , P_IFRS_PROGRESS_YEAR      --(IFRS)내용년수
        , P_IFRS_RESIDUAL_AMOUNT    --(IFRS)잔존가액
        , NVL(P_IFRS_DPR_STATUS_CODE, '20')    --(IFRS)상각상태 20:미상각
        
        , t_ASSET_ID    --자산아이디
        , t_ASSET_CODE  --자산코드
        , P_ASSET_STATUS_CODE          --자산상태  [10(사용)]
        , 'Y'           --(IFRS)상각여부 [N:미상각,Y:상각]
        , '1'           --(K-GAAP)감가상각방법   [1(정액법)]
        
        , GET_LOCAL_DATE(P_SOB_ID)  --생성일자
        , P_CREATED_BY              --생성자
        , GET_LOCAL_DATE(P_SOB_ID)  --최종수정일자
        , P_CREATED_BY              --최종수정자 
        , P_TAX_CODE                --사업장코드 
    );
    
    
    --감가상각스케쥴 생성
    CREATE_ASSET_DPR_HISTORY(
          P_SOB_ID                  --회사아이디
        , P_ORG_ID                  --사업부아이디
        
        , P_ASSET_CATEGORY_ID       --자산유형아이디    
        , t_ASSET_ID                --자산아이디
        , P_IFRS_DPR_METHOD_TYPE    --(IFRS)감가상각방법_코드 
        , P_COST_CENTER_ID          --원가아이디        

        , P_ACQUIRE_DATE            --취득일자 
        , P_IFRS_PROGRESS_YEAR      --(IFRS)내용년수
        , P_AMOUNT                  --취득금액 
        , P_IFRS_RESIDUAL_AMOUNT    --(IFRS)잔존가액        

        , P_CREATED_BY              --생성자     
    );

END INS_ASSET_MASTER;







--감가상각스케쥴 생성
PROCEDURE CREATE_ASSET_DPR_HISTORY( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --사업부아이디

    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_DPR_HISTORY.ASSET_CATEGORY_ID%TYPE --자산유형아이디
    , P_ASSET_ID                IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE          --자산아이디
    , P_DPR_METHOD_TYPE         IN  FI_ASSET_DPR_HISTORY.DPR_METHOD_TYPE%TYPE   --감가상각방법
    , P_COST_CENTER_ID          IN  FI_ASSET_DPR_HISTORY.COST_CENTER_ID%TYPE    --원가아이디
    
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --취득일자 
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)내용년수
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --취득금액 
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)잔존가액    
    
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --생성자     
)

AS

t_DPR_COUNT         FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차
t_PERIOD_NAME       FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE;      --상각년월
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --(최초)감가상각비
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --감가상각누계액
t_DISUSE_YN         FI_ASSET_DPR_HISTORY.DISUSE_YN%TYPE;        --마지막회차여부

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);


BEGIN

    --상각회차를 구한다. 구한 상각회차 만큼 DATA가 INSERT된다.
    --상각회차 = 내용년수 * 12
    SELECT P_IFRS_PROGRESS_YEAR * 12 
    INTO t_DPR_COUNT
    FROM DUAL;
    

    --감가상각방법(1:정액법, 2:정율법)
    IF P_DPR_METHOD_TYPE = '1' THEN --1:정액법

        --상각금액(감가상각비)을 구한다.
        --감가상각비 = 감가상각대상금액(취득금액 - 잔존가액) / 내용년수
        SELECT ROUND( (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) / t_DPR_COUNT, 0)
        INTO t_DPR_AMOUNT
        FROM DUAL   ;
        
        
        t_DISUSE_YN := 'N'; --마지막회차여부
        
        
        --상각회차 만큼 DATA INSERT
        FOR DPR_CREATE IN 1..t_DPR_COUNT
        LOOP
        
            SELECT
                  TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, DPR_CREATE - 1), 'YYYY-MM')
                , t_DPR_AMOUNT * DPR_CREATE
            INTO 
                  t_PERIOD_NAME     --상각년월
                , t_DPR_SUM_AMOUNT  --감가상각누계액 = 상각금액(감가상각비) * 상각회차 = 전회차의 감가상각누계액 + 당회차의 감가상각비
            FROM DUAL   ;
                 
            
            --단, 마지막 상각회차의 경우 
            --감가상각비는 단수조정된 액수가  [좀 편하방법으로 구하기 위해 아래의 산식으로 대체했다.]
            --감가상각누계액은 (취득금액 - 잔존가치)의 금액이 설정된다.
            IF DPR_CREATE = t_DPR_COUNT THEN            
                SELECT (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) - (t_DPR_AMOUNT * (t_DPR_COUNT - 1)) --감가상각비
                    , P_AMOUNT -  P_IFRS_RESIDUAL_AMOUNT    --감가상각누계액
                INTO t_DPR_AMOUNT
                    , t_DPR_SUM_AMOUNT
                FROM DUAL   ;
                
                t_DISUSE_YN := 'Y'; --마지막회차여부
            END IF;            
            
                    
            INSERT INTO FI_ASSET_DPR_HISTORY( 
                  SOB_ID            --회사아이디
                , ORG_ID            --사업부아이디
                , ASSET_CATEGORY_ID --자산유형아이디
                , ASSET_ID          --자산아이디    
                , COST_CENTER_ID    --원가아이디
                , DPR_METHOD_TYPE   --감가상각방법
                , DPR_TYPE          --회계구분[20 : IFRS]        
                , DPR_YN            --감가상각여부        
                , SLIP_YN           --전표생성여부
                
                , DPR_COUNT             --상각회차    
                , PERIOD_NAME           --상각년월
                , DPR_AMOUNT            --(최초)감가상각비
                , SP_DPR_AMOUNT         --추가상각액(예>자본적지출)
                , SP_MNS_DPR_AMOUNT     --차감상각액(예>부분매각)
                , SOURCE_AMOUNT         --(최종)감가상각비
                , DPR_SUM_AMOUNT        --감가상각누계액
                , UN_DPR_REMAIN_AMOUNT  --미상각잔액
                , DISUSE_YN             --마지막회차여부
                
                , CREATION_DATE     --생성일자
                , CREATED_BY        --생성자
                , LAST_UPDATE_DATE  --최종수정일자
                , LAST_UPDATED_BY   --최종수정자 
            )
            VALUES
            ( 
                  P_SOB_ID              --회사아이디
                , P_ORG_ID              --사업부아이디
                , P_ASSET_CATEGORY_ID   --자산유형아이디
                , P_ASSET_ID            --자산아이디    
                , P_COST_CENTER_ID      --원가아이디
                , P_DPR_METHOD_TYPE     --감가상각방법
                , '20'                  --회계구분[20 : IFRS]        
                , 'N'                   --감가상각여부        
                , 'N'                   --전표생성여부
                
                , DPR_CREATE            --상각회차    
                , t_PERIOD_NAME         --상각년월
                , t_DPR_AMOUNT          --(최초)감가상각비
                , 0                     --추가상각액(예>자본적지출)
                , 0                     --차감상각액(예>부분매각)
                , t_DPR_AMOUNT          --(최종)감가상각비
                , t_DPR_SUM_AMOUNT              --감가상각누계액
                , P_AMOUNT - t_DPR_SUM_AMOUNT   --미상각잔액 = 취득금액 - 감가상각누계액
                , t_DISUSE_YN           --마지막회차여부
                
                , V_SYSDATE             --생성일자
                , P_CREATED_BY          --생성자
                , V_SYSDATE             --최종수정일자
                , P_CREATED_BY          --최종수정자 
            )   ;

        END LOOP DPR_CREATE;   

    ELSIF P_DPR_METHOD_TYPE = '2' THEN  --2:정율법

        NULL;     

    END IF;    

END CREATE_ASSET_DPR_HISTORY;










--이 PROCEDURE는 가 등록된 자산의 감가상각스케쥴 생성을 위한 임시성 PROCEDURE로 
--지금 시점(2011.10.24) 외에는 사용되지 않는 것이다.
PROCEDURE CREATE_BATCH_DPR( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --사업부아이디       
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --생성자 
)

AS

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);


BEGIN
    --FI_ASSET_DPR_HISTORY(자산별감가상각스케쥴내역) 테이블 자료 정리
    DELETE FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID   ;


    FOR DPR_CREATE IN (
        SELECT
              SOB_ID                --회사아이디
            , ORG_ID                --사업부아이디
            , ASSET_CATEGORY_ID     --자산유형아이디
            , ASSET_ID              --자산아이디
            , IFRS_DPR_METHOD_TYPE  --(IFRS)감가상각방법
            , COST_CENTER_ID        --원가아이디    
            , ACQUIRE_DATE          --취득일자 
            , IFRS_PROGRESS_YEAR    --(IFRS)내용년수
            , AMOUNT                --취득금액 
            , IFRS_RESIDUAL_AMOUNT  --(IFRS)잔존가액           
        FROM FI_ASSET_MASTER
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID        
    )
    LOOP               

        --감가상각스케쥴 생성
        CREATE_ASSET_DPR_HISTORY(
              DPR_CREATE.SOB_ID                  --회사아이디
            , DPR_CREATE.ORG_ID                  --사업부아이디
            
            , DPR_CREATE.ASSET_CATEGORY_ID       --자산유형아이디    
            , DPR_CREATE.ASSET_ID                --자산아이디
            , DPR_CREATE.IFRS_DPR_METHOD_TYPE    --(IFRS)감가상각방법_코드 
            , DPR_CREATE.COST_CENTER_ID          --원가아이디        

            , DPR_CREATE.ACQUIRE_DATE            --취득일자 
            , DPR_CREATE.IFRS_PROGRESS_YEAR      --(IFRS)내용년수
            , DPR_CREATE.AMOUNT                  --취득금액 
            , DPR_CREATE.IFRS_RESIDUAL_AMOUNT    --(IFRS)잔존가액        

            , P_CREATED_BY              --생성자     
        );

    END LOOP DPR_CREATE;  

END CREATE_BATCH_DPR;











--자산대장 수정
PROCEDURE UPD_ASSET_MASTER( 
      W_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE         --회사아이디
    , W_ASSET_CODE              IN  FI_ASSET_MASTER.ASSET_CODE%TYPE     --자산코드
      
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE     --자산명     
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE            --수량
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE        --용도
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE      --거래처아이디
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE --관리부서아이디
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE --비고

    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --등록일자       
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --경비구분
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --원가아이디
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --자산상태
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)상각상태   

    , P_LAST_UPDATED_BY         IN  FI_ASSET_MASTER.LAST_UPDATED_BY%TYPE    --최종수정자
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- 사업장코드.
)

AS

BEGIN

    UPDATE FI_ASSET_MASTER
    SET
          ASSET_DESC            = P_ASSET_DESC              --자산명     
        , QTY                   = P_QTY                     --수량
        , PURPOSE               = P_PURPOSE                 --용도
        , VENDOR_ID             = P_VENDOR_ID               --거래처아이디
        , MANAGE_DEPT_ID        = P_MANAGE_DEPT_ID          --관리부서아이디
        , REMARK                = P_REMARK                  --비고
        , REGISTER_DATE         = P_REGISTER_DATE           --등록일자       
        , EXPENSE_TYPE          = P_EXPENSE_TYPE            --경비구분
        , COST_CENTER_ID        = P_COST_CENTER_ID          --원가아이디        
        , ASSET_STATUS_CODE     = P_ASSET_STATUS_CODE       --자산상태
        , IFRS_DPR_STATUS_CODE  = P_IFRS_DPR_STATUS_CODE    --(IFRS)상각상태
        
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(SOB_ID)    --최종수정일자
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --최종수정자
        , TAX_CODE              = P_TAX_CODE                -- 사업장코드 
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CODE = W_ASSET_CODE ;

END UPD_ASSET_MASTER;







--자산대장 삭제
PROCEDURE DEL_ASSET_MASTER(
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --회사아이디
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_CODE%TYPE --자산아이디
)

AS

t_SLIP_CNT          NUMBER := 0;
t_ASSET_HISTORY_CNT NUMBER := 0;
BASE_DATA           EXCEPTION;

BEGIN

    --해당 자산의 감가상각스케쥴 자료 중 전표로 등록된 자료가 있는지를 파악한다.
    SELECT COUNT(*)
    INTO t_SLIP_CNT
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND DPR_TYPE = '20'
        AND ASSET_ID = W_ASSET_ID
        AND SLIP_YN = 'Y'   ;      
    
    --해당 자산의 자산변동내역 자료가 있는지를 파악한다.
    SELECT COUNT(*)
    INTO t_ASSET_HISTORY_CNT
    FROM FI_ASSET_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
     
       
    --해당 자산의 감가상각스케쥴 자료 중 전표로 등록된 자료 또는 자산변동내역 자료가 있는 경우 경고메시지를 띄운다.
    IF t_SLIP_CNT > 0 OR t_ASSET_HISTORY_CNT > 0 THEN
      RAISE BASE_DATA;
    END IF;      


    --해당 자산의 자료를 삭제한다.
    DELETE FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID ;
        
        
    --FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 삭제하려는 자산의 감가상각스케쥴 자료를 삭제한다.  
    DELETE FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND DPR_TYPE = '20' --20:IFRS
        AND ASSET_ID = W_ASSET_ID ;      
  
        
EXCEPTION
    WHEN BASE_DATA THEN
        --FCM_10307, 기준자료로 삭제할 수 없습니다.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10307', NULL));

END DEL_ASSET_MASTER;







--자산변동내역 조회
PROCEDURE LIST_ASSET_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_HISTORY.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID      IN  FI_ASSET_HISTORY.ORG_ID%TYPE    --사업부어이디
    , W_ASSET_ID    IN  FI_ASSET_HISTORY.ASSET_ID%TYPE  --자산아이디
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID      --회사아이디
        , A.ORG_ID      --사업부아이디
        , A.ASSET_ID    --자산아이디
        , B.ASSET_CODE  --자산코드
        , B.ASSET_DESC  --자산명
        , A.HISTORY_NUM --자산변동번호
        
        , A.CHARGE_DATE --변경일자
        , A.CHARGE_ID   --변경사유_아이디
        , FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --변경사유
        , A.AMOUNT          --(변동후)금액
        , A.COST_CENTER_ID  --(변동후)원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명
        -- 2013.06.06 전호수 추가 : 사업장 정보 --       
        , A.TAX_CODE
        , FI_COMMON_G.CODE_NAME_F('TAX_CODE', A.TAX_CODE, A.SOB_ID, A.ORG_ID) AS TAX_DESC
        
        , A.QTY         --(변동후)수량
        , A.DEPT_ID     --관리부서_아이디
        , FI_DEPT_MASTER_G.DEPT_NAME_F(A.DEPT_ID) AS MANAGE_DEPT_NM --관리부서         
        , A.DESCRIPTION --비고  
        --, A.LOCATION_ID --자산위치아이디
        --, FI_COMMON_G.ID_NAME_F(A.LOCATION_ID) AS LOCATION_NM    --자산위치   
    FROM FI_ASSET_HISTORY A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC 
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ASSET_ID = W_ASSET_ID
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY CHARGE_DATE   ;

END LIST_ASSET_HISTORY;







--자산변동내역 신규자료 등록
PROCEDURE INS_ASSET_HISTORY( 
      P_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , P_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디    
    , P_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자
    , P_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE         --변경사유_아이디
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --(변동후)원가아이디
    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(변동후)수량 
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --관리부서_아이디
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --비고    
    
    , P_CREATED_BY      IN  FI_ASSET_HISTORY.CREATED_BY%TYPE        --생성자 
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- 사업장코드 
)

AS

t_CODE  FI_COMMON.CODE%TYPE; --공통코드

t_ASSET_STATUS_CODE  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE; --자산상태

t_CHARGE_DATE  FI_ASSET_HISTORY.CHARGE_DATE%TYPE; --변경일자


t_CNT   NUMBER := 0;    --해당 자산의 상각완료된 회차의 자료가 있는지를 파악하기 위함.

--해당 자산의 상태가 매각 또는 폐기된 경우 우리의 자산이 아닌데 자산변동내역을 등록할 수 없다.
OTHERS_ASSET    EXCEPTION;

--변경일자는 상각이 된 후의 월부터 입력이 가능하므로 이를 확인한다.
CHARGE_DATE    EXCEPTION;

BEGIN

    SELECT ASSET_STATUS_CODE
    INTO t_ASSET_STATUS_CODE
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_ID = P_ASSET_ID   ;


    --해당 자산의 상태가 매각 또는 폐기된 경우 우리의 자산이 아닌데 자산변동내역을 등록할 수 없다.
    IF t_ASSET_STATUS_CODE IN ('80', '90') THEN --80 : 매각, 90 : 폐기
      RAISE OTHERS_ASSET;
    END IF;
    
    
    --해당 자산의 상각완료된 회차의 자료가 있는지를 파악하기 위함.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID
        AND ASSET_ID = P_ASSET_ID
        AND DPR_YN = 'Y'    ;    
    

    IF t_CNT > 0 THEN

        --변경일자는 상각이 된 후의 월부터 입력이 가능하므로 이를 확인한다.
        SELECT ADD_MONTHS(TO_DATE(PERIOD_NAME, 'YYYY-MM'), 1)
        INTO t_CHARGE_DATE
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND ASSET_ID = P_ASSET_ID
            AND DPR_YN = 'Y'
            AND DPR_COUNT = (
                    SELECT MAX(DPR_COUNT)
                    FROM FI_ASSET_DPR_HISTORY
                    WHERE SOB_ID = P_SOB_ID
                        AND ORG_ID = P_ORG_ID
                        AND ASSET_ID = P_ASSET_ID
                        AND DPR_YN = 'Y'    
                )   ;
                
        IF P_CHARGE_DATE < t_CHARGE_DATE THEN
            RAISE CHARGE_DATE;
        END IF;                

    END IF;
    

    INSERT INTO FI_ASSET_HISTORY( 
          SOB_ID            --회사아이디
        , ORG_ID            --사업부아이디
        , HISTORY_NUM       --자산변동번호
        , ASSET_ID          --자산아이디    
        , CHARGE_DATE       --변경일자
        , CHARGE_ID         --변경사유_아이디
        , AMOUNT            --(변동후)금액
        , COST_CENTER_ID    --(변동후)원가아이디
        , QTY               --(변동후)수량
        , DEPT_ID           --관리부서_아이디
        , DESCRIPTION       --비고    
        
        , CREATION_DATE     --생성일자
        , CREATED_BY        --생성자
        , LAST_UPDATE_DATE  --최종수정일자
        , LAST_UPDATED_BY   --최종수정자 
        , TAX_CODE          --사업장코드 
    )
    VALUES
    ( 
          P_SOB_ID          --회사아이디
        , P_ORG_ID          --사업부아이디        
        , (SELECT NVL(MAX(TO_NUMBER(HISTORY_NUM)), 0) + 1 FROM FI_ASSET_HISTORY)   --자산변동번호
        , P_ASSET_ID        --자산아이디    
        , P_CHARGE_DATE     --변경일자
        , P_CHARGE_ID       --변경사유_아이디
        , P_AMOUNT          --(변동후)금액
        , P_COST_CENTER_ID  --(변동후)원가아이디
        , P_QTY             --(변동후)수량 
        , P_DEPT_ID         --관리부서_아이디
        , P_DESCRIPTION     --비고 
        
        , GET_LOCAL_DATE(P_SOB_ID)  --생성일자
        , P_CREATED_BY              --생성자
        , GET_LOCAL_DATE(P_SOB_ID)  --최종수정일자
        , P_CREATED_BY              --최종수정자 
        , P_TAX_CODE                --변경후 사업장코드 
    );
    
    -- 자산변동 : 변경전 자료 반영 --
    UPDATE FI_ASSET_HISTORY AH
      SET (BF_COST_CENTER_ID
        , BF_QTY            
        , BF_DEPT_ID 
        , BF_TAX_CODE) =
        (SELECT COST_CENTER_ID
              , QTY            
              , MANAGE_DEPT_ID 
              , TAX_CODE
           FROM FI_ASSET_MASTER AM
          WHERE AM.ASSET_ID   = AH.ASSET_ID
        )
     WHERE AH.ASSET_ID        = P_ASSET_ID
    ;
    
    -- 자산대장 업데이트 --
    UPDATE FI_ASSET_MASTER
    SET   COST_CENTER_ID      = P_COST_CENTER_ID
        , QTY                 = P_QTY
        , MANAGE_DEPT_ID      = P_DEPT_ID
        , TAX_CODE            = P_TAX_CODE
        , LAST_UPDATE_DATE    = GET_LOCAL_DATE(SOB_ID) --최종수정일자
        , LAST_UPDATED_BY     = P_CREATED_BY            --최종수정자
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_ID = P_ASSET_ID ;

    SELECT FI_COMMON_G.GET_CODE_F(P_CHARGE_ID, P_SOB_ID, P_ORG_ID)
    INTO t_CODE
    FROM DUAL   ;

    --변경사유가 자본적 지출이면
    IF t_CODE = '10' THEN
        --변경일 익월부터 감가상각스케쥴 재 생성
        CHG_ASSET_DPR_HISTORY(
              P_SOB_ID          --회사아이디
            , P_ORG_ID          --사업부아이디
            , P_ASSET_ID        --자산아이디
            , P_CHARGE_DATE     --변경일자
            , P_AMOUNT          --(변동후)금액
            , P_COST_CENTER_ID  --(변동후)원가아이디
            , P_CREATED_BY      --최종수정자
        )   ;
    ELSIF t_CODE = '92' THEN   --92 : 부분매각
        CHG_ASSET_DPR_HISTORY_PART(
              P_SOB_ID          --회사아이디
            , P_ORG_ID          --사업부아이디
            , P_ASSET_ID        --자산아이디
            , P_CHARGE_DATE     --변경일자
            , P_AMOUNT          --(변동후)금액
            , P_COST_CENTER_ID  --(변동후)원가아이디
            , P_CREATED_BY      --최종수정자
        )   ;    
    ELSIF t_CODE = '90' THEN   --90 : 자산폐기
        UPDATE FI_ASSET_MASTER
        SET
              ASSET_STATUS_CODE = '90'                  --자산상태; 90 : 폐기 
            , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID) --최종수정일자
            , LAST_UPDATED_BY = P_CREATED_BY            --최종수정자
        WHERE SOB_ID = P_SOB_ID
            AND ASSET_ID = P_ASSET_ID ;
            
        --자본변동내역 등록 시 [단, 자본적지출, 부분매각 제외]
        --FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 해당 자산의 원가아이디 변경
        --감가상각방법(1:정액법, 2:정율법)이 뭐든간에 관계없다. 동일하게 적용된다.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --회사아이디
            , P_ORG_ID          --사업부아이디
            , P_ASSET_ID        --자산아이디
            , P_CHARGE_DATE     --변경일자
            , P_COST_CENTER_ID  --(변동후)원가아이디
            , P_CREATED_BY      --최종수정자        
        );            
    ELSIF t_CODE = '91' THEN   --91 : 자산매각
        UPDATE FI_ASSET_MASTER
        SET
              ASSET_STATUS_CODE = '80'                  --자산상태; 80 : 매각            
            , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID) --최종수정일자
            , LAST_UPDATED_BY = P_CREATED_BY            --최종수정자
        WHERE SOB_ID = P_SOB_ID
            AND ASSET_ID = P_ASSET_ID ;
            
        --자본변동내역 등록 시 [단, 자본적지출, 부분매각 제외]
        --FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 해당 자산의 원가아이디 변경
        --감가상각방법(1:정액법, 2:정율법)이 뭐든간에 관계없다. 동일하게 적용된다.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --회사아이디
            , P_ORG_ID          --사업부아이디
            , P_ASSET_ID        --자산아이디
            , P_CHARGE_DATE     --변경일자
            , P_COST_CENTER_ID  --(변동후)원가아이디
            , P_CREATED_BY      --최종수정자        
        );            
    ELSE
        
        --자본변동내역 등록 시 [단, 자본적지출, 부분매각 제외]
        --FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 해당 자산의 원가아이디 변경
        --감가상각방법(1:정액법, 2:정율법)이 뭐든간에 관계없다. 동일하게 적용된다.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --회사아이디
            , P_ORG_ID          --사업부아이디
            , P_ASSET_ID        --자산아이디
            , P_CHARGE_DATE     --변경일자
            , P_COST_CENTER_ID  --(변동후)원가아이디
            , P_CREATED_BY      --최종수정자        
        );
    
    END IF;    
    

EXCEPTION
    WHEN OTHERS_ASSET THEN
        --FCM_10403, 매각 또는 폐기된 자산으로 변동내역을 등록할 수 없습니다.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10403', NULL));
        
    WHEN CHARGE_DATE THEN
        --FCM_10404, 변경일자는 최종상각월 익월의 일자부터 입력 가능합니다.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10404', NULL));        


END INS_ASSET_HISTORY;





--자본적지출에 따른 추가상각액 설정 및 감가상각누계액과 미상각잔액 금액 변경
PROCEDURE CHG_ASSET_DPR_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자       
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액; 추가되는 감가상각대상금액이다.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
)

AS

t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차_자본적지출에 따른 변경이 시작될 상각차수
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차_자본적지출에 따른 변경이 종료될 상각차수
t_DPR_MM_CNT        NUMBER := 0;    --자본적지출에 따른 감가상각비가 변경될 상각월수를 구한다.
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --감가상각비
t_DPR_AMOUNT_CALC   FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --감가상각비_계산용
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --감가상각누계액

t_GET_AMOUNT        FI_ASSET_MASTER.AMOUNT%TYPE;                --취득금액
t_CHG_AMOUNT        FI_ASSET_HISTORY.AMOUNT%TYPE;               --자본적지출금액 합계

t_DPR_METHOD_TYPE   FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE;  --감가상각방법

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);


BEGIN

    --취득금액, 감가상각방법
    SELECT AMOUNT, IFRS_DPR_METHOD_TYPE 
    INTO t_GET_AMOUNT, t_DPR_METHOD_TYPE
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
        
        
    --취득가액을 구하기 위해 자산변동내역의 자본적지출 금액의 합을 구한다.
    SELECT SUM(AMOUNT)
    INTO t_CHG_AMOUNT
    FROM FI_ASSET_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID = W_ASSET_ID
        AND CHARGE_ID = (SELECT COMMON_ID
                         FROM FI_COMMON
                         WHERE GROUP_CODE = 'ASSET_CHARGE' AND CODE = '10')    ;   
    
    --최종최득가액
    t_GET_AMOUNT := t_GET_AMOUNT + t_CHG_AMOUNT;
    
    
    --감가상각방법(1:정액법, 2:정율법)
    IF t_DPR_METHOD_TYPE = '1' THEN --1:정액법
    
        --상각회차_자본적지출에 따른 변경이 시작될 상각차수
        SELECT DPR_COUNT
        INTO t_DPR_COUNT_FR
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --회계구분[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID
            AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;

        --상각회차_자본적지출에 따른 변경이 종료될 상각차수
        SELECT MAX(DPR_COUNT)
        INTO t_DPR_COUNT_TO
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --회계구분[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID   ;


        --자본적지출에 따른 감가상각비가 변경될 상각월수를 구한다.
        SELECT t_DPR_COUNT_TO - t_DPR_COUNT_FR + 1
        INTO t_DPR_MM_CNT
        FROM DUAL   ;


        --추가될 감가상각비를 구한다.
        SELECT ROUND( P_AMOUNT / t_DPR_MM_CNT, 0)
        INTO t_DPR_AMOUNT
        FROM DUAL   ;        
        
        
        --상각회차 만큼 DATA INSERT
        FOR DPR_CHG IN (
            SELECT
                  ASSET_ID              --자산아이디        
                , DPR_COUNT             --상각회차    
                , DPR_AMOUNT            --감가상각비
                , SP_DPR_AMOUNT         --추가상각액(예>자본적지출)
                , DPR_SUM_AMOUNT        --감가상각누계액
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID
                AND DPR_COUNT BETWEEN t_DPR_COUNT_FR AND t_DPR_COUNT_TO 
            ORDER BY DPR_COUNT
        )
        LOOP
            --변수 초기화
            t_DPR_SUM_AMOUNT := 0;
        
            --변경하려는 상각회차 직전의 감가상각누계액을 구한다.
            SELECT DPR_SUM_AMOUNT
            INTO t_DPR_SUM_AMOUNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = (DPR_CHG.DPR_COUNT - 1)   ;
            
            IF DPR_CHG.DPR_COUNT = t_DPR_COUNT_TO THEN 
                --단, 마지막 상각회차의 경우 
                --추가상각액(예>자본적지출)은 단수조정된 액수 
                --변경된 감가상각누계액 = 전 회차의 감가상각누계액 + ( 원래의 감가상각비 +  추가상각액)                
            
                SELECT DPR_CHG.SP_DPR_AMOUNT + P_AMOUNT - t_DPR_AMOUNT * (t_DPR_COUNT_TO - t_DPR_COUNT_FR)  --추가상각액
                    , t_DPR_SUM_AMOUNT + DPR_CHG.DPR_AMOUNT + 
                            ( DPR_CHG.SP_DPR_AMOUNT + P_AMOUNT - t_DPR_AMOUNT * (t_DPR_COUNT_TO - t_DPR_COUNT_FR) ) --추가상각액
                INTO t_DPR_AMOUNT_CALC
                    , t_DPR_SUM_AMOUNT
                FROM DUAL   ;
                
            ELSE    --상각회차가 마지막이 아닌경우
            
                t_DPR_AMOUNT_CALC := DPR_CHG.SP_DPR_AMOUNT + t_DPR_AMOUNT;   --추가상각액(예>자본적지출)

                --변경된 감가상각누계액 = 전 회차의 감가상각누계액 + ( 원래의 감가상각비 +  추가상각액)
                t_DPR_SUM_AMOUNT := t_DPR_SUM_AMOUNT + ( DPR_CHG.DPR_AMOUNT + DPR_CHG.SP_DPR_AMOUNT + t_DPR_AMOUNT);
            
            END IF;            


            UPDATE FI_ASSET_DPR_HISTORY
            SET   SP_DPR_AMOUNT = t_DPR_AMOUNT_CALC    --추가상각액(예>자본적지출)
            
                --(최종)감가상각비 = (최초)감가상각비 + 추가상각액 - 차감상각액
                , SOURCE_AMOUNT = DPR_AMOUNT + t_DPR_AMOUNT_CALC - SP_MNS_DPR_AMOUNT
                
                , DPR_SUM_AMOUNT = t_DPR_SUM_AMOUNT --변경된 감가상각누계액
                
                --변경된 미상각잔액 = 취득가액 - 변경된 감가상각누계액
                --참조>취득가액 = 취득금액 + 자본적지출금액의 합계
                , UN_DPR_REMAIN_AMOUNT = t_GET_AMOUNT - t_DPR_SUM_AMOUNT
                
                , COST_CENTER_ID = P_COST_CENTER_ID --원가아이디
                , REMARK = REMARK || '자본적지출(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --비고
                , LAST_UPDATE_DATE = V_SYSDATE          --최종수정일자
                , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --최종수정자
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = DPR_CHG.DPR_COUNT   ;
                        
        END LOOP DPR_CHG;   

    ELSIF t_DPR_METHOD_TYPE = '2' THEN  --2:정율법

        NULL;

    END IF;    

END CHG_ASSET_DPR_HISTORY;







--부분매각에 따른 차감상각액 설정 및 감가상각누계액과 미상각잔액 금액 변경
PROCEDURE CHG_ASSET_DPR_HISTORY_PART( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자       
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(변동후)금액; 부분매각금액; 차감되는 감가상각대상금액이다.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
)

AS

t_DPR_COUNT         FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차
t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차_부분매각에 따른 변경이 시작될 상각차수
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --상각회차_부분매각에 따른 변경이 종료될 상각차수
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --감가상각비
t_DPR_AMOUNT_CALC   FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --감가상각비_계산용
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --감가상각누계액
t_SOURCE_AMOUNT     FI_ASSET_DPR_HISTORY.SOURCE_AMOUNT%TYPE;    --(최종)감가상각비

t_UN_DPR_REMAIN_AMOUNT  FI_ASSET_DPR_HISTORY.UN_DPR_REMAIN_AMOUNT%TYPE; --미상각잔액
t_GET_AMOUNT            FI_ASSET_MASTER.AMOUNT%TYPE;                    --취득금액
t_IFRS_PROGRESS_YEAR    FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE;        --내용년수
t_IFRS_RESIDUAL_AMOUNT  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE;      --잔존가액

t_DPR_MM_CNT        NUMBER := 0;    --부분매각에 따른 감가상각비가 변경될 상각월수를 구한다.
t_DPR_TARGET_AMOUNT NUMBER := 0;    --부분매각에 따른 감가상각대상금액
t_MM_MINUS_AMOUNT   NUMBER := 0;    --부분매각에 따른 월 차감상각액

t_DPR_METHOD_TYPE   FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE;  --감가상각방법

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);


BEGIN

    --취득금액, 감가상각방법, (IFRS)내용년수, (IFRS)잔존가액
    SELECT AMOUNT, IFRS_DPR_METHOD_TYPE, IFRS_PROGRESS_YEAR, IFRS_RESIDUAL_AMOUNT 
    INTO t_GET_AMOUNT, t_DPR_METHOD_TYPE, t_IFRS_PROGRESS_YEAR, t_IFRS_RESIDUAL_AMOUNT
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
        
        
    --상각회차를 구한다. 구한 상각회차 만큼 DATA가 INSERT된다.
    --상각회차 = 내용년수 * 12
    SELECT t_IFRS_PROGRESS_YEAR * 12 
    INTO t_DPR_COUNT
    FROM DUAL   ;
    
    --부분매각에 따른 감가상각대상금액을 구한다.
    --부분매각에 따른 감가상각대상금액 = 취득금액 - 부분매각금액 - 잔존가액
    SELECT t_GET_AMOUNT - P_AMOUNT - t_IFRS_RESIDUAL_AMOUNT
    INTO t_DPR_TARGET_AMOUNT
    FROM DUAL   ;  
    
    
    --부분매각에 따른 월 감가상각비를 구한다.
    --부분매각에 따른 월 감가상각비 = 부분매각에 따른 감가상각대상금액 / 상각회차
    SELECT ROUND(t_DPR_TARGET_AMOUNT / t_DPR_COUNT, 0)
    INTO t_DPR_AMOUNT
    FROM DUAL  ;
    
    
    --상각회차_부분매각에 따른 변경이 시작될 상각차수
    SELECT DPR_COUNT
    INTO t_DPR_COUNT_FR
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND DPR_TYPE = '20' --회계구분[20 : IFRS]
        AND ASSET_ID = W_ASSET_ID
        AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;
        
        
    --부분매각 후 취득원가 = 자산 취득당시의 취득금액 - 부분매각금액
    t_GET_AMOUNT := t_GET_AMOUNT - P_AMOUNT;
        

    --부분매각이 발생한 회차의 감가상각누계액과 미상각잔액을 변경한다.
    UPDATE FI_ASSET_DPR_HISTORY
    SET
          --변경된 감가상각누계액 = 부분매각에 따른 월 감가상각비 * 부분매각에 따른 변경이 시작될 상각차수
          DPR_SUM_AMOUNT = t_DPR_AMOUNT * t_DPR_COUNT_FR
        
        --변경된 미상각잔액 = 부분매각 후 취득원가 - 변경된 감가상각누계액
        , UN_DPR_REMAIN_AMOUNT = t_GET_AMOUNT - (t_DPR_AMOUNT * t_DPR_COUNT_FR)
        
        , REMARK = REMARK || '부분매각(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --비고
        , LAST_UPDATE_DATE = V_SYSDATE          --최종수정일자
        , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --최종수정자
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND DPR_TYPE = '20' --회계구분[20 : IFRS]
        AND ASSET_ID = W_ASSET_ID 
        AND DPR_COUNT = t_DPR_COUNT_FR   ;       

    
    --감가상각방법(1:정액법, 2:정율법)
    IF t_DPR_METHOD_TYPE = '1' THEN --1:정액법
    
        --부분매각에 따른 월 차감상각액 = 부분매각금액 / 상각회차
        SELECT ROUND(P_AMOUNT / t_DPR_COUNT, 0)
        INTO t_MM_MINUS_AMOUNT
        FROM DUAL   ;    

        --상각회차_부분매각에 따른 변경이 종료될 상각차수
        SELECT MAX(DPR_COUNT)
        INTO t_DPR_COUNT_TO
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --회계구분[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID   ;
       
       t_DPR_COUNT_FR := t_DPR_COUNT_FR + 1;
        
        --상각회차 만큼 DATA INSERT
        FOR DPR_CHG IN (
            SELECT
                  ASSET_ID              --자산아이디        
                , DPR_COUNT             --상각회차    
                , DPR_AMOUNT            --감가상각비
                , SP_DPR_AMOUNT         --추가상각액
                , SP_MNS_DPR_AMOUNT     --차감상각액(예>부분매각)
                , DPR_SUM_AMOUNT        --감가상각누계액
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID
                AND DPR_COUNT BETWEEN t_DPR_COUNT_FR AND t_DPR_COUNT_TO 
            ORDER BY DPR_COUNT
        )
        LOOP
            --변수 초기화
            t_DPR_SUM_AMOUNT := 0;
        
            --변경하려는 상각회차 직전의 감가상각누계액을 구한다.
            SELECT DPR_SUM_AMOUNT
            INTO t_DPR_SUM_AMOUNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = (DPR_CHG.DPR_COUNT - 1)   ;
            
            IF DPR_CHG.DPR_COUNT = t_DPR_COUNT_TO THEN  -- 마지막 상각회차의 경우 
                
                --(최종)감가상각비
                t_SOURCE_AMOUNT := t_DPR_TARGET_AMOUNT - t_DPR_SUM_AMOUNT;
                
                --차감상각액(예>부분매각)
                t_DPR_AMOUNT_CALC := DPR_CHG.DPR_AMOUNT - t_SOURCE_AMOUNT;
                
                --변경된 감가상각누계액 = 부분매각에 따른 감가상각대상금액
                t_DPR_SUM_AMOUNT := t_DPR_TARGET_AMOUNT;
                
                --변경된 미상각잔액 = 잔존가액
                t_UN_DPR_REMAIN_AMOUNT := t_IFRS_RESIDUAL_AMOUNT;
                
            ELSE    --상각회차가 마지막이 아닌경우
            
                t_DPR_AMOUNT_CALC := DPR_CHG.SP_MNS_DPR_AMOUNT + t_MM_MINUS_AMOUNT;   --차감상각액(예>부분매각)
                
                --(최종)감가상각비 = (최초)감가상각비 + 추가상각액 - 차감상각액
                t_SOURCE_AMOUNT := DPR_CHG.DPR_AMOUNT + DPR_CHG.SP_DPR_AMOUNT - t_DPR_AMOUNT_CALC;

                --변경된 감가상각누계액 = 전 회차의 감가상각누계액 + (최종)감가상각비
                t_DPR_SUM_AMOUNT := t_DPR_SUM_AMOUNT + t_SOURCE_AMOUNT;
            
                --변경된 미상각잔액 = 부분매각 후 취득원가 - 변경된 감가상각누계액
                t_UN_DPR_REMAIN_AMOUNT := t_GET_AMOUNT - t_DPR_SUM_AMOUNT;
            END IF;            


            UPDATE FI_ASSET_DPR_HISTORY
            SET   SP_MNS_DPR_AMOUNT = t_DPR_AMOUNT_CALC         --차감상각액(예>부분매각)            
                , SOURCE_AMOUNT = t_SOURCE_AMOUNT               --(최종)감가상각비                
                , DPR_SUM_AMOUNT = t_DPR_SUM_AMOUNT             --변경된 감가상각누계액                                
                , UN_DPR_REMAIN_AMOUNT = t_UN_DPR_REMAIN_AMOUNT --변경된 미상각잔액
                
                , COST_CENTER_ID = P_COST_CENTER_ID --원가아이디
                , REMARK = REMARK || '부분매각(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --비고
                , LAST_UPDATE_DATE = V_SYSDATE          --최종수정일자
                , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --최종수정자
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = DPR_CHG.DPR_COUNT   ;
                        
        END LOOP DPR_CHG;   

    ELSIF t_DPR_METHOD_TYPE = '2' THEN  --2:정율법

        NULL;

    END IF;    

END CHG_ASSET_DPR_HISTORY_PART;











--자본변동내역 등록 시 [단, 자본적지출, 부분매각 제외]
--FI_ASSET_DPR_HISTORY(고정자산_감가상각스케쥴내역) 테이블에서 해당 자산의 원가아이디 변경
--감가상각방법(1:정액법, 2:정율법)이 뭐든간에 관계없다. 동일하게 적용된다.
PROCEDURE UPD_ASSET_DPR_HISTORY_COST( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --자산아이디    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --변경일자       
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --원가아이디    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자 
)

AS

t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --변경이 시작될 상각차수
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --변경이 종료될 상각차수

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN        
    
    BEGIN
      --변경이 시작될 상각차수
      SELECT DPR_COUNT
      INTO t_DPR_COUNT_FR
      FROM FI_ASSET_DPR_HISTORY
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID 
          AND DPR_TYPE = '20' --회계구분[20 : IFRS]
          AND ASSET_ID = W_ASSET_ID
          AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;
    EXCEPTION WHEN OTHERS THEN
      t_DPR_COUNT_FR := 0;
    END;           
    
    BEGIN
      --변경이 종료될 상각차수
      SELECT MAX(DPR_COUNT)
      INTO t_DPR_COUNT_TO
      FROM FI_ASSET_DPR_HISTORY
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID 
          AND DPR_TYPE = '20' --회계구분[20 : IFRS]
          AND ASSET_ID = W_ASSET_ID   ;    
    EXCEPTION WHEN OTHERS THEN
      t_DPR_COUNT_TO := 0;
    END;
    

    FOR COST_CHG IN t_DPR_COUNT_FR .. t_DPR_COUNT_TO
    LOOP

        UPDATE FI_ASSET_DPR_HISTORY
        SET   COST_CENTER_ID = P_COST_CENTER_ID     --원가아이디
            , LAST_UPDATE_DATE = V_SYSDATE          --최종수정일자
            , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --최종수정자
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --회계구분[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID 
            AND DPR_COUNT = COST_CHG    ;
                    
    END LOOP COST_CHG;   




END UPD_ASSET_DPR_HISTORY_COST;










--자산변동내역 수정
PROCEDURE UPD_ASSET_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --사업부아이디 
    , W_HISTORY_NUM     IN  FI_ASSET_HISTORY.HISTORY_NUM%TYPE       --자산변동번호         

    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(변동후)수량       
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --비고
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --관리부서_아이디

    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --최종수정자
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- 사업장코드
)

AS

BEGIN

    UPDATE FI_ASSET_HISTORY
    SET
          QTY               = P_QTY         --(변동후)수량     
        , DESCRIPTION       = P_DESCRIPTION --비고
        , DEPT_ID           = P_DEPT_ID     --관리부서_아이디
        
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)    --최종수정일자
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         --최종수정자
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND HISTORY_NUM = W_HISTORY_NUM ;

END UPD_ASSET_HISTORY;





--자산별 감가상각스케쥴 조회
PROCEDURE LIST_ASSET_DPR_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE    --사업부어이디
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE  --자산아이디
    --, W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE  --회계구분    
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --회사아이디
        , A.ORG_ID              --사업부아이디
        , A.ASSET_CATEGORY_ID   --자산유형아이디
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --자산유형
        , A.ASSET_ID        --자산아이디
        , B.ASSET_CODE      --자산코드
        , B.ASSET_DESC      --자산명
        
        , NVL(A.DPR_YN, 'N') AS DPR_YN  --(감가)상각여부    
        , A.DPR_COUNT                   --상각회차    
        , A.PERIOD_NAME                 --상각년월
        , A.DPR_AMOUNT                  --(최초)감가상각비
        , A.SP_DPR_AMOUNT               --추가상각액(예>자본적지출)
        , A.SP_MNS_DPR_AMOUNT           --차감상각액(예>부분매각)
        --, A.DPR_AMOUNT + A.SP_DPR_AMOUNT - A.SP_MNS_DPR_AMOUNT  AS LAST_DPR_AMOUNT  --변경된감가상각비
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(최종)감가상각비
        , A.DPR_SUM_AMOUNT          --감가상각누계액
        , A.UN_DPR_REMAIN_AMOUNT    --미상각잔액

        , B.EXPENSE_TYPE    --경비구분
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --경비구분     
        , A.COST_CENTER_ID  --원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명         
        , NVL(A.SLIP_YN, 'N') AS SLIP_YN  --전표생성여부
        , A.SLIP_DATE   --전표일자
        , A.GL_NUM      --전표번호
        , A.REMARK      --비고
        , A.DPR_TYPE    --회계구분_코드[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --회계구분
        , A.DPR_METHOD_TYPE --감가상각방법_코드
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --감가상각방법       
        --, A.DPR_YEAR_AMOUNT         --년상각금액
        --, A.DPR_SUM_AMOUNT          --년상각금액; 년상각누계액
        --, A.UN_DPR_REMAIN_AMOUNT    --미상각금액    
    FROM FI_ASSET_DPR_HISTORY A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --회계구분[20 : IFRS]
        AND A.ASSET_ID = W_ASSET_ID
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY A.DPR_COUNT    ;

END LIST_ASSET_DPR_HISTORY;






--자산명 반환
FUNCTION  F_ASSET_DESC( 
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID      IN  FI_ASSET_MASTER.ORG_ID%TYPE     --사업부아이디
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_ID%TYPE   --자산아이디
) RETURN VARCHAR2

AS

t_ASSET_DESC   FI_ASSET_MASTER.ASSET_DESC%TYPE := '';

BEGIN
    
    SELECT ASSET_DESC
    INTO t_ASSET_DESC
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND ASSET_ID = W_ASSET_ID    ;

    RETURN t_ASSET_DESC;

END F_ASSET_DESC   ;






--자산명 선택 POPUP
PROCEDURE POPUP_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE    
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    SELECT 
          ASSET_DESC    --자산명
        , ASSET_CODE    --자산코드
        , ASSET_ID      --자산아이디
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
    ORDER BY ASSET_CODE    ;
  
END POPUP_ASSET_MASTER;










--자산변동내역 PG의 자산변동내역 조회
--참조>LIST_ASSET_HISTORY PROCEDURE와 동일하다.
PROCEDURE LIST_ASSET_HISTORY_ALL( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE        --회사아이디
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE        --사업부어이디    
    , W_CHARGE_DATE_FR  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --변경일자_시작
    , W_CHARGE_DATE_TO  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --변경일자_종료
    , W_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE     --변경사유아이디
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID      --회사아이디
        , A.ORG_ID      --사업부아이디
        , A.ASSET_ID    --자산아이디
        , B.ASSET_CODE  --자산코드
        , B.ASSET_DESC  --자산명
        , B.ASSET_STATUS_NM  --자산상태
        , B.ACQUIRE_DATE   --취득일자
        , B.AMOUNT AS GET_AMOUNT         --취득금액
        , B.IFRS_PROGRESS_YEAR --(IFRS)내용년수
    
        , A.HISTORY_NUM --자산변동번호       
        , A.CHARGE_DATE --변경일자
        , A.CHARGE_ID   --변경사유_아이디
        , FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --변경사유
        , A.AMOUNT AS CHG_AMOUNT          --(변동후)금액
        , A.COST_CENTER_ID  --(변동후)원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명
        , A.QTY         --(변동후)수량
        , A.DEPT_ID     --관리부서_아이디
        , FI_DEPT_MASTER_G.DEPT_NAME_F(A.DEPT_ID) AS MANAGE_DEPT_NM --관리부서         
        , A.DESCRIPTION --비고    
    FROM FI_ASSET_HISTORY A
        , (SELECT
              ASSET_ID
            , ASSET_CODE
            , ASSET_DESC
            , ASSET_STATUS_CODE  --자산상태
            , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', ASSET_STATUS_CODE, SOB_ID) AS ASSET_STATUS_NM  --자산상태
            , ACQUIRE_DATE   --취득일자
            , AMOUNT         --취득금액
            , IFRS_PROGRESS_YEAR --(IFRS)내용년수
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ASSET_ID = B.ASSET_ID
        
        AND CHARGE_DATE BETWEEN NVL(W_CHARGE_DATE_FR, CHARGE_DATE) AND NVL(W_CHARGE_DATE_TO, CHARGE_DATE)
        AND CHARGE_ID = NVL(W_CHARGE_ID, CHARGE_ID)
    ORDER BY CHARGE_DATE, CHARGE_ID   ;

END LIST_ASSET_HISTORY_ALL;








END FI_ASSET_MASTER_G;
/
