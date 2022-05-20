/*-- 자산 대장반영 --
DECLARE

BEGIN
  FOR C1 IN ( SELECT AM.ASSET_ID 
                   , AM.ASSET_CODE 
                   , AM.ASSET_DESC 
                   , AM.SOB_ID 
                   , AM.ORG_ID 
                   , AM.EXPENSE_TYPE 
                   --, AM.ASSET_CATEGORY_ID 
                   , AM.SPEC 
                   , AM.PURPOSE 
                   , AM.ACQUIRE_DATE 
                   , AM.REGISTER_DATE 
                   , AM.LOCATION_ID 
                   , AM.LOCATION_DESC 
                   , AM.QTY 
                   , AM.UOM_CODE 
                   , AM.INVEST_ID 
                   , AM.UNIT_PRICE 
                   , AM.CURRENCY_CODE 
                   , AM.EXCHANGE_RATE 
                   , AM.CURR_AMOUNT 
                   , AM.AMOUNT 
                   , AM.DPR_YN 
                   , AM.DPR_METHOD_TYPE 
                   , AM.DPR_PROGRESS_YEAR 
                   , AM.RESIDUAL_AMOUNT 
                   , AM.DPR_STATUS_CODE 
                   , AM.DPR_SUM_CURR_AMOUNT 
                   , AM.DPR_SUM_AMOUNT 
                   , AM.DPR_TOTAL_COUNT 
                   , AM.DPR_LAST_PERIOD 
                   , AM.IFRS_DPR_YN 
                   , AM.IFRS_DPR_METHOD_TYPE 
                  -- , AM.IFRS_PROGRESS_YEAR 
                   --, AM.IFRS_RESIDUAL_AMOUNT 
                   , AM.IFRS_DPR_STATUS_CODE 
                   , AM.IFRS_DPR_SUM_CURR_AMOUNT 
                   , AM.IFRS_DPR_SUM_AMOUNT 
                   , AM.IFRS_DPR_TOTAL_COUNT 
                   , AM.IFRS_DPR_LAST_PERIOD 
                   , AM.VENDOR_ID 
                   , AM.MANAGE_DEPT_ID 
                   , AM.COST_CENTER_ID 
                   , AM.ASSET_STATUS_CODE 
                   , AM.DISUSE_DATE 
                   , AM.REMARK 
                   , AM.SOURCE_TABLE 
                   , AM.SOURCE_HEADER_ID 
                   , AM.SOURCE_LINE_ID 
                   , AM.ATTRIBUTE_A 
                   , AM.ATTRIBUTE_B 
                   , AM.ATTRIBUTE_C 
                   , AM.ATTRIBUTE_D 
                   , AM.ATTRIBUTE_E 
                   , AM.ATTRIBUTE_1 
                   , AM.ATTRIBUTE_2 
                   , AM.ATTRIBUTE_3 
                   , AM.ATTRIBUTE_4 
                   , AM.ATTRIBUTE_5 
                   , AM.CREATION_DATE 
                   , AM.CREATED_BY 
                   , AM.LAST_UPDATE_DATE 
                   , AM.LAST_UPDATED_BY 
                   , AM.TAX_CODE 
                   , ACC.ASSET_CATEGORY_ID  
                   --, ACC.EXPENSE_TYPE
                   --, ACC.IFRS_DPR_METHOD_TYPE
                   , ACC.IFRS_PROGRESS_YEAR
                   , ACC.IFRS_RESIDUAL_AMOUNT
                FROM FI_ASSET_MASTER      AM
                   , FI_ASSET_CATEGORY    FAC
                   , FI_ASSET_CATEGORY_CG ACC
               WHERE AM.ASSET_CATEGORY_ID     = FAC.ASSET_CATEGORY_ID 
                 AND FAC.ASSET_CATEGORY_CODE  = ACC.ASSET_CATEGORY_CODE
                 AND FAC.SOB_ID               = ACC.SOB_ID
                 AND AM.ACQUIRE_DATE          BETWEEN '2013-01-01' AND '2013-12-31'
             )
  LOOP
    FI_ASSET_MASTER_CG_G.INS_ASSET_MASTER_CG
      ( P_SOB_ID                  => C1.SOB_ID                 --회사아이디
      , P_ORG_ID                  => C1.ORG_ID                 --사업부아이디     
      , P_ASSET_CATEGORY_ID       => C1.ASSET_CATEGORY_ID      --자산유형아이디
      , P_ASSET_DESC              => C1.ASSET_DESC             --자산명
      , P_ACQUIRE_DATE            => C1.ACQUIRE_DATE           --취득일자
      , P_REGISTER_DATE           => C1.REGISTER_DATE          --등록일자
      , P_AMOUNT                  => C1.AMOUNT                 --취득금액 
      , P_EXPENSE_TYPE            => C1.EXPENSE_TYPE           --경비구분
      , P_COST_CENTER_ID          => C1.COST_CENTER_ID         --원가아이디
      , P_QTY                     => C1.QTY                    --수량
      , P_PURPOSE                 => C1.PURPOSE                --용도
      , P_VENDOR_ID               => C1.VENDOR_ID              --거래처아이디
      , P_MANAGE_DEPT_ID          => C1.MANAGE_DEPT_ID         --관리부서아이디
      , P_REMARK                  => C1.REMARK                 --비고
      , P_IFRS_DPR_METHOD_TYPE    => C1.IFRS_DPR_METHOD_TYPE   --(IFRS)감가상각방법
      , P_IFRS_PROGRESS_YEAR      => C1.IFRS_PROGRESS_YEAR     --(IFRS)내용년수
      , P_IFRS_RESIDUAL_AMOUNT    => C1.IFRS_RESIDUAL_AMOUNT   --(IFRS)잔존가액
      , P_IFRS_DPR_STATUS_CODE    => C1.IFRS_DPR_STATUS_CODE   --(IFRS)상각상태
      
      , P_ASSET_STATUS_CODE       => C1.ASSET_STATUS_CODE      --자산상태    

      , P_CREATED_BY              => C1.CREATED_BY             --생성자  
      , P_TAX_CODE                => C1.TAX_CODE               -- 사업장코드. 
      , P_OLD_ASSET_ID            => C1.ASSET_ID               -- OLD 자산ID 
      );              
  END LOOP C1;   
END;   */
/*
-- 자산 변동 반영 --
DECLARE

BEGIN
  
  FOR C1 IN ( SELECT AMC.ASSET_ID
                   , AMC.SOB_ID
                   , AMC.ORG_ID
                   , AH.CHARGE_DATE
                   , AH.CHARGE_ID
                   , AH.AMOUNT
                   , AH.COST_CENTER_ID
                   , AH.QTY
                   , AH.DEPT_ID
                   , AH.DESCRIPTION
                   , AH.CREATED_BY
                   , AH.TAX_CODE
                FROM FI_ASSET_MASTER_CG AMC
                   , FI_ASSET_HISTORY   AH
               WHERE AMC.ATTRIBUTE_1    = AH.ASSET_ID
            )         
  LOOP 
    FI_ASSET_MASTER_CG_G.INS_ASSET_HISTORY_CG
      ( P_SOB_ID          => C1.SOB_ID            --회사아이디
      , P_ORG_ID          => C1.ORG_ID            --사업부아이디    
      , P_ASSET_ID        => C1.ASSET_ID          --자산아이디    
      , P_CHARGE_DATE     => C1.CHARGE_DATE       --변경일자
      , P_CHARGE_ID       => C1.CHARGE_ID         --변경사유_아이디
      , P_AMOUNT          => C1.AMOUNT            --(변동후)금액
      , P_COST_CENTER_ID  => C1.COST_CENTER_ID    --(변동후)원가아이디
      , P_QTY             => C1.QTY               --(변동후)수량 
      , P_DEPT_ID         => C1.DEPT_ID           --관리부서_아이디
      , P_DESCRIPTION     => C1.DESCRIPTION       --비고    
        
      , P_CREATED_BY      => C1.CREATED_BY        --생성자 
      , P_TAX_CODE        => C1.TAX_CODE          -- 사업장코드 
      );
  END LOOP C1;
END;
*/
/*
SELECT *
  FROM FI_ASSET_MASTER_CG
 ;
 
SELECT *
  FROM FI_ASSET_DPR_HISTORY_CG X
 WHERE X.ASSET_ID              = 4
ORDER BY X.PERIOD_NAME */
