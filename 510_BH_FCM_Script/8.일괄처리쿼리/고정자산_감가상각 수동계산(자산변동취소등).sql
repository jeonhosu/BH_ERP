/*
select *
  from fi_asset_master_cg x
 where x.asset_code    = 'B000000181'
 ;

select *
  from fi_asset_history x
 where x.asset_id       = 405
for update 
 ; 
 
SELECT *
  FROM FI_ASSET_DPR_HISTORY X
 WHERE X.ASSET_ID           = 177
ORDER BY X.PERIOD_NAME 
for update
;

-- 감가상각 자본적 지출금액 및 누계액 미상각잔액 UPDATE -- 
UPDATE FI_ASSET_DPR_HISTORY ADH
   SET ADH.REMARK                 = NULL
 WHERE ADH.ASSET_ID               = 3513
;

-- 감가상각 자본적 지출금액 및 누계액 미상각잔액 UPDATE -- 
UPDATE FI_ASSET_DPR_HISTORY ADH
   SET ADH.SOURCE_AMOUNT          = NVL(ADH.SOURCE_AMOUNT, 0) - NVL(ADH.SP_DPR_AMOUNT, 0)
     , ADH.SP_DPR_AMOUNT          = 0
 WHERE ADH.ASSET_ID               = 3513
;
 
*/
DECLARE
      P_SOB_ID                  NUMBER := 10;
      P_ORG_ID                  NUMBER := 101;
      P_ASSET_ID                NUMBER := 3513;
      
      P_ASSET_CATEGORY_ID       NUMBER;      
      P_DPR_METHOD_TYPE         VARCHAR2(2) := '1';  -- 정액법.
      P_COST_CENTER_ID          NUMBER;              --원가아이디
    
      P_ACQUIRE_DATE            DATE;                --취득일자 
      P_IFRS_PROGRESS_YEAR      NUMBER;              --(IFRS)내용년수
      P_AMOUNT                  NUMBER;              --취득금액 
      P_IFRS_RESIDUAL_AMOUNT    NUMBER;              --(IFRS)잔존가액    
    
      P_CREATED_BY              NUMBER;              --생성자     

      t_DPR_COUNT         NUMBER;        --상각회차
      t_PERIOD_NAME       VARCHAR2(10);      --상각년월
      t_DPR_AMOUNT        NUMBER;       --(최초)감가상각비
      t_DPR_SUM_AMOUNT    NUMBER;   --감가상각누계액
      t_DISUSE_YN         VARCHAR2(5);        --마지막회차여부

      V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN
    BEGIN
      SELECT AM.ASSET_CATEGORY_ID
           , AM.COST_CENTER_ID
           , AM.ACQUIRE_DATE
           , AM.IFRS_PROGRESS_YEAR
           , AM.AMOUNT
           , AM.IFRS_RESIDUAL_AMOUNT
           , AM.LAST_UPDATED_BY
        INTO P_ASSET_CATEGORY_ID
           , P_COST_CENTER_ID
           , P_ACQUIRE_DATE
           , P_IFRS_PROGRESS_YEAR
           , P_AMOUNT
           , P_IFRS_RESIDUAL_AMOUNT
           , P_CREATED_BY
        FROM FI_ASSET_MASTER AM
       WHERE AM.ASSET_ID          = P_ASSET_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('자산 정보 조회 오류 : ' || SQLERRM);
        RETURN;  
    END;
    
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
            
            -- 감가상각 반영 -- 
            MERGE INTO FI_ASSET_DPR_HISTORY ADH
              USING (SELECT P_SOB_ID AS SOB_ID           --회사아이디
                          , P_ORG_ID AS ORG_ID           --사업부아이디
                          , P_ASSET_ID AS ASSET_ID       --자산아이디    
                          , P_DPR_METHOD_TYPE AS DPR_METHOD_TYPE   --감가상각방법
                          , t_PERIOD_NAME AS PERIOD_NAME           --상각년월
                        FROM DUAL
                    ) SX1
              ON ( ADH.SOB_ID            = SX1.SOB_ID
                AND ADH.ORG_ID           = SX1.ORG_ID
                AND ADH.ASSET_ID         = SX1.ASSET_ID
                AND ADH.DPR_METHOD_TYPE   = SX1.DPR_METHOD_TYPE 
                AND ADH.PERIOD_NAME       = SX1.PERIOD_NAME 
                 )
            WHEN MATCHED THEN
              UPDATE 
                 SET DPR_AMOUNT            = t_DPR_AMOUNT          --(최종)감가상각비
                   , SP_DPR_AMOUNT         = 0                     --추가상각액(예>자본적지출)
                   , SP_MNS_DPR_AMOUNT     = 0                     --차감상각액(예>부분매각)
                   , SOURCE_AMOUNT         = t_DPR_AMOUNT          --(최종)감가상각비
                   , DPR_SUM_AMOUNT        = t_DPR_SUM_AMOUNT              --감가상각누계액
                   , UN_DPR_REMAIN_AMOUNT  = P_AMOUNT - t_DPR_SUM_AMOUNT   --미상각잔액 = 취득금액 - 감가상각누계액
            WHEN NOT MATCHED THEN
              INSERT  
                ( 
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

END;
