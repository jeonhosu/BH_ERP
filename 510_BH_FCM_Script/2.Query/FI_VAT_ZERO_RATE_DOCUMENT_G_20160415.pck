CREATE OR REPLACE PACKAGE FI_VAT_ZERO_RATE_DOCUMENT_G
AS

-- VAT 영세율매출명세서 조회.
  PROCEDURE SELECT_ZERO_RATE_DOCUMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --회사아이디
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --사업부아이디
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --사업장아이디(예>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호 
            );


-- VAT 영세율매출명세서 합계 금액 UPDATE.
  PROCEDURE SET_SUM_ZERO_RATE_DOCUMENT
            ( W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --회사아이디
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --사업부아이디
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --사업장아이디(예>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호 
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );


  --  사업자 인적사항 인쇄 -- 
  PROCEDURE PRINT_ZERO_RATE_DOCUMENT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_SOB_ID          IN  NUMBER  --회사아이디
            , W_ORG_ID          IN  NUMBER  --사업부아이디 
            , W_TAX_CODE        IN  VARCHAR2
            , W_VAT_MNG_SERIAL  IN  NUMBER
            , W_DEAL_DATE_FR    IN  DATE    --거래기간_시작
            , W_DEAL_DATE_TO    IN  DATE    --거래기간_종료    
            );
                        
END FI_VAT_ZERO_RATE_DOCUMENT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_ZERO_RATE_DOCUMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_ZERO_RATE_DOCUMENT_G
/* Description  : 영세율 매출명세서 관리.
/*
/* Reference by : 영세율 첨부서 생성시 영세율 매출명세서에 합계 금액을 SAVE한다.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 영세율매출명세서 조회.
  PROCEDURE SELECT_ZERO_RATE_DOCUMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --회사아이디
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --사업부아이디
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --사업장아이디(예>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호 
            )
  AS
    V_STATUS            VARCHAR2(2);
    V_MESSAGE           VARCHAR2(500);
  BEGIN
    SET_SUM_ZERO_RATE_DOCUMENT
      ( W_SOB_ID            => W_SOB_ID
      , W_ORG_ID            => W_ORG_ID
      , W_TAX_CODE          => W_TAX_CODE
      , W_VAT_MNG_SERIAL    => W_VAT_MNG_SERIAL
      , O_STATUS            => V_STATUS      
      , O_MESSAGE           => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      RAISE_APPLICATION_ERROR(-20001, W_TAX_CODE || '-' ||  V_MESSAGE);
      RETURN;
    END IF;
              
    OPEN P_CURSOR FOR
      SELECT ZRD.V_11_01_01_1     -- 직접수출(대행수출 포함) 
           , ZRD.V_11_01_01_2     -- 중계무역/위탁판매/외국인도 또는 위탁가공무역 방식의 수출 
           , ZRD.V_11_01_01_3     -- 내국신용장/구매확인서에 의하여 공급하는 재화 
           , ZRD.V_11_01_01_4     -- 한국국제협력단 및 한국국제보건의료재단에 공급하는 해외반출용 재화 
           , ZRD.V_11_01_01_5     -- 수탁가공무역 수출용으로 공급하는 재화 
           , ZRD.V_11_01_02_1     -- 국외에서 제공하는 용역 
           , ZRD.V_11_01_03_1     -- 선박/항공기에 의한 외국항행용역 
           , ZRD.V_11_01_03_2     -- 국제복합운송계약에 의한 외국항행용역 
           , ZRD.V_11_01_04_1     -- 국내에서 비거주자/외국법인에게 공급되는 재화 또는 용역 
           , ZRD.V_11_01_04_2     -- 수출재화임가공용역 
           , ZRD.V_11_01_04_3     -- 외국항행 선박/항공기 등에 공급하는 재화 또는 용역  
           , ZRD.V_11_01_04_4     -- 국내 주재 외교공관/영사기관/국제연합과 이에 준하는 국제기구, 국제연합군 또는 미국군에게 공급하는 재화 또는 용역 
           , ZRD.V_11_01_04_5     -- 관광진흥법에 따른 일반여행업자 또는 외국인전용 관광기념품 판매업자가 외국인관광객에게 공급하는 관광알선 용역 또는 관광기념품 
           , ZRD.V_11_01_04_6     -- 외국인전용판매장 또는 주한외국군인 등의 전용 유흥음식점에서 공급하는 재화 또는 용역 
           , ZRD.V_11_01_04_7     -- 외교관 등에게 공급하는 재화 또는 용역 
           , ZRD.V_11_01_04_8     -- 외국인환자 유치용역 
           , ZRD.V_SUM_AMT        -- 부가가치세법에 따른 영세율 적용 공급실적 합계 
           , ZRD.T_105_01_01_1    -- 방위산업물자 및 군부대 등에 공급하는 석유류 
           , ZRD.T_105_01_03_1    -- 도시철도건설용역 
           , ZRD.T_105_01_03_2    -- 국가/지방자치단체에 공급하는 사회기반시설등 
           , ZRD.T_105_01_04_1    -- 장애인용 보장구 및 장애인용 정보통신기기 등 
           , ZRD.T_105_01_05_1    -- 농/어민 등에게 공급하는 농업용/축산업용/임업용 또는 어업용 기자재 
           , ZRD.T_107_00_00_0    -- 외국인관광객 등에게 공급하는 재화 
           , ZRD.T_121_13_00_0    -- 제주특별자치도 면세품판매장에서 판매하거나 제주특별자치도 면세품판매장에 공급하는 물품 
           , ZRD.T_SUM_AMT        -- 조특법 및 그 밖의 법률에 따른 영세율 적용 공급실적 합계 
           , ZRD.TOTAL_AMT        -- 영세율 적용 공급실적 총 합계 
           , ZRD.TAX_CODE
           , ZRD.VAT_MNG_SERIAL
           , ZRD.T_105_01_01_1_1  -- 군부대공급석유류 
           , ZRD.T_105_01_05_1_1  -- 어민에게 공급하는 어업용기자재 
        FROM FI_VAT_ZERO_RATE_DOCUMENT ZRD
      WHERE ZRD.TAX_CODE          = W_TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = W_SOB_ID
        AND ZRD.ORG_ID            = W_ORG_ID
      ;
  END SELECT_ZERO_RATE_DOCUMENT;


-- VAT 영세율매출명세서 합계 금액 UPDATE.
  PROCEDURE SET_SUM_ZERO_RATE_DOCUMENT
            ( W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --회사아이디
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --사업부아이디
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --사업장아이디(예>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호 
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_USER_ID           NUMBER := GET_USER_ID_F;
  BEGIN
    O_STATUS := 'F';
    
    -- 0. 초기화 --
    UPDATE FI_VAT_ZERO_RATE_DOCUMENT ZRD
       SET ZRD.V_11_01_01_1       = 0
         , ZRD.V_11_01_01_2       = 0
         , ZRD.V_11_01_01_3       = 0
         , ZRD.V_11_01_01_4       = 0
         , ZRD.V_11_01_01_5       = 0
         , ZRD.V_11_01_02_1       = 0
         , ZRD.V_11_01_03_1       = 0
         , ZRD.V_11_01_03_2       = 0
         , ZRD.V_11_01_04_1       = 0
         , ZRD.V_11_01_04_2       = 0
         , ZRD.V_11_01_04_3       = 0
         , ZRD.V_11_01_04_4       = 0
         , ZRD.V_11_01_04_5       = 0
         , ZRD.V_11_01_04_6       = 0
         , ZRD.V_11_01_04_7       = 0
         , ZRD.V_11_01_04_8       = 0
         , ZRD.V_SUM_AMT          = 0
         , ZRD.T_105_01_01_1      = 0
         , ZRD.T_105_01_03_1      = 0
         , ZRD.T_105_01_03_2      = 0
         , ZRD.T_105_01_04_1      = 0
         , ZRD.T_105_01_05_1      = 0
         , ZRD.T_107_00_00_0      = 0
         , ZRD.T_121_13_00_0      = 0
         , ZRD.T_SUM_AMT          = 0
         , ZRD.TOTAL_AMT          = 0
      WHERE ZRD.TAX_CODE          = W_TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = W_SOB_ID
        AND ZRD.ORG_ID            = W_ORG_ID
    ;
    
    -- 1.직접수출(대행수출 포함) --
    -- 1.1. 수출실적명세서 --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING( SELECT W_SOB_ID AS SOB_ID	        --회사아이디
                , W_ORG_ID AS ORG_ID	        --사업부아이디
                , W_TAX_CODE AS TAX_CODE      	--사업장아이디
                , W_VAT_MNG_SERIAL AS VAT_MNG_SERIAL	--부가세신고기간구분번호
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS BASE_AMOUNT     --원화; 공급가액            
          FROM FI_SLIP_LINE   A
             , FI_SLIP_HEADER B
          WHERE   A.SLIP_HEADER_ID = B.SLIP_HEADER_ID
              AND A.SOB_ID = W_SOB_ID
              AND A.ORG_ID = W_ORG_ID 
              AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
              AND MANAGEMENT2 = '3'           --세무유형 : 수출
              AND A.REFER11 = W_TAX_CODE      --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
              AND EXISTS
                      ( SELECT 'X'
                          FROM FI_VAT_REPORT_MNG VRM
                         WHERE VRM.SOB_ID          = A.SOB_ID
                           AND VRM.ORG_ID          = A.ORG_ID
                           AND VRM.TAX_CODE        = A.REFER11
                           AND VRM.VAT_MNG_SERIAL  = W_VAT_MNG_SERIAL
                           AND TO_DATE(A.REFER1)   BETWEEN VRM.TAX_TERM_FR AND VRM.TAX_TERM_TO
                       )  
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_1     = NVL(ZRD.V_11_01_01_1, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_1 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_1 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;           
    
    /*-- 2 중계무역/위탁판매/외국인도 또는 위탁가공무역방식의 수출 --
    -- 2.1 외화획득명세서 -- 
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING(SELECT
                  SOB_ID	        --회사아이디
                , ORG_ID	        --사업부아이디
                , TAX_CODE	      --사업장아이디
                , VAT_MNG_SERIAL	--부가세신고기간구분번호
                , SUM(NVL(SUPPLY_AMT, 0)) AS BASE_AMOUNT	    --공급가액               
            FROM FI_FOREIGN_CURRENCY_SPEC
            WHERE SOB_ID = W_SOB_ID
              AND ORG_ID = W_ORG_ID
              AND TAX_CODE = W_TAX_CODE
              AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL                
           GROUP BY SOB_ID	        --회사아이디
                  , ORG_ID	        --사업부아이디
                  , TAX_CODE	      --사업장아이디
                  , VAT_MNG_SERIAL	--부가세신고기간구분번호
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_2     = NVL(ZRD.V_11_01_01_2, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_2 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_2 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;     */  
        
    -- 3 내국신용장/구매확인서에 의하여 공급하는 재화 
    -- 3.1 영세율첨부서류 --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING(SELECT 
                  SOB_ID            --회사아이디
                , ORG_ID            --사업부아이디
                , TAX_CODE          --사업장아이디
                , VAT_MNG_SERIAL    --부가세신고기간구분번호
                , SUM(NVL(SUBMIT_KOREAN_AMT, 0)) AS BASE_AMOUNT     --당기제출원화                
            FROM FI_ZERO_TAX_SPEC ZTS
            WHERE ZTS.SOB_ID = W_SOB_ID
              AND ZTS.ORG_ID = W_ORG_ID
              AND ZTS.TAX_CODE = W_TAX_CODE
              AND ZTS.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
              AND EXISTS
                    ( SELECT 'X'
                        FROM FI_VAT_REPORT_MNG VRM
                       WHERE VRM.SOB_ID          = ZTS.SOB_ID
                         AND VRM.ORG_ID          = ZTS.ORG_ID
                         AND VRM.TAX_CODE        = ZTS.TAX_CODE
                         AND VRM.VAT_MNG_SERIAL  = ZTS.VAT_MNG_SERIAL
                    )
           GROUP BY SOB_ID            --회사아이디
                  , ORG_ID            --사업부아이디
                  , TAX_CODE          --사업장아이디
                  , VAT_MNG_SERIAL    --부가세신고기간구분번호
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_3     = NVL(ZRD.V_11_01_01_3, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_3 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_3 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;        
    
    /*-- 3.2 내국신용장 --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING( SELECT
                  SOB_ID	            --회사아이디
                , ORG_ID	            --사업부아이디
                , TAX_CODE	    --사업장아이디
                , VAT_MNG_SERIAL	    --부가세신고기간구분번호
                , SUM(NVL(SUPPLY_AMT, 0)) AS BASE_AMOUNT	        --금액
            FROM FI_DOMESTIC_LC       
            WHERE SOB_ID = W_SOB_ID
              AND ORG_ID = W_ORG_ID
              AND TAX_CODE = W_TAX_CODE               --사업장아이디
              AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호                  
           GROUP BY SOB_ID            --회사아이디
                  , ORG_ID            --사업부아이디
                  , TAX_CODE          --사업장아이디
                  , VAT_MNG_SERIAL    --부가세신고기간구분번호                          
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_3     = NVL(ZRD.V_11_01_01_3, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_3 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_3 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;   */    
    
    -- 영세율 매출명세서 합계 금액 계산 --
    UPDATE FI_VAT_ZERO_RATE_DOCUMENT ZRD
       SET ZRD.V_SUM_AMT    = NVL(ZRD.V_11_01_01_1, 0) + 
                              NVL(ZRD.V_11_01_01_2 , 0) + 
                              NVL(ZRD.V_11_01_01_3 , 0) + 
                              NVL(ZRD.V_11_01_01_4 , 0) + 
                              NVL(ZRD.V_11_01_01_5 , 0) + 
                              NVL(ZRD.V_11_01_02_1 , 0) + 
                              NVL(ZRD.V_11_01_03_1 , 0) + 
                              NVL(ZRD.V_11_01_03_2 , 0) + 
                              NVL(ZRD.V_11_01_04_1 , 0) + 
                              NVL(ZRD.V_11_01_04_2 , 0) + 
                              NVL(ZRD.V_11_01_04_3 , 0) + 
                              NVL(ZRD.V_11_01_04_4 , 0) + 
                              NVL(ZRD.V_11_01_04_5 , 0) + 
                              NVL(ZRD.V_11_01_04_6 , 0) + 
                              NVL(ZRD.V_11_01_04_7 , 0) + 
                              NVL(ZRD.V_11_01_04_8 , 0)
         , ZRD.T_SUM_AMT    = NVL(ZRD.T_105_01_01_1, 0) + 
                              NVL(ZRD.T_105_01_03_1 , 0) + 
                              NVL(ZRD.T_105_01_03_2 , 0) + 
                              NVL(ZRD.T_105_01_04_1 , 0) + 
                              NVL(ZRD.T_105_01_05_1 , 0) + 
                              NVL(ZRD.T_107_00_00_0 , 0) + 
                              NVL(ZRD.T_121_13_00_0 , 0)
         , ZRD.TOTAL_AMT    = NVL(ZRD.V_11_01_01_1, 0) + 
                              NVL(ZRD.V_11_01_01_2 , 0) + 
                              NVL(ZRD.V_11_01_01_3 , 0) + 
                              NVL(ZRD.V_11_01_01_4 , 0) + 
                              NVL(ZRD.V_11_01_01_5 , 0) + 
                              NVL(ZRD.V_11_01_02_1 , 0) + 
                              NVL(ZRD.V_11_01_03_1 , 0) + 
                              NVL(ZRD.V_11_01_03_2 , 0) + 
                              NVL(ZRD.V_11_01_04_1 , 0) + 
                              NVL(ZRD.V_11_01_04_2 , 0) + 
                              NVL(ZRD.V_11_01_04_3 , 0) + 
                              NVL(ZRD.V_11_01_04_4 , 0) + 
                              NVL(ZRD.V_11_01_04_5 , 0) + 
                              NVL(ZRD.V_11_01_04_6 , 0) + 
                              NVL(ZRD.V_11_01_04_7 , 0) + 
                              NVL(ZRD.V_11_01_04_8 , 0) +
                              NVL(ZRD.T_105_01_01_1, 0) + 
                              NVL(ZRD.T_105_01_03_1 , 0) + 
                              NVL(ZRD.T_105_01_03_2 , 0) + 
                              NVL(ZRD.T_105_01_04_1 , 0) + 
                              NVL(ZRD.T_105_01_05_1 , 0) + 
                              NVL(ZRD.T_107_00_00_0 , 0) + 
                              NVL(ZRD.T_121_13_00_0 , 0)
     WHERE ZRD.SOB_ID = W_SOB_ID
       AND ZRD.ORG_ID = W_ORG_ID
       AND ZRD.TAX_CODE = W_TAX_CODE               --사업장아이디
       AND ZRD.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호      
    ;
    
    O_STATUS := 'S';
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'Creation Data Error : ' || SUBSTR(SQLERRM, 1, 150);
  END SET_SUM_ZERO_RATE_DOCUMENT;




  --  사업자 인적사항 인쇄 -- 
  PROCEDURE PRINT_ZERO_RATE_DOCUMENT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_SOB_ID          IN  NUMBER  --회사아이디
            , W_ORG_ID          IN  NUMBER  --사업부아이디 
            , W_TAX_CODE        IN  VARCHAR2
            , W_VAT_MNG_SERIAL  IN  NUMBER
            , W_DEAL_DATE_FR    IN  DATE    --거래기간_시작
            , W_DEAL_DATE_TO    IN  DATE    --거래기간_종료    
            )

  AS
    V_FY                VARCHAR2(4);
    V_VAT_REPORT_TURN   VARCHAR2(70);
    V_VAT_REPORT_GB     VARCHAR2(70);
  BEGIN
    BEGIN
      SELECT VRM.FY 
           , VRM.VAT_REPORT_TURN 
           , VRM.VAT_REPORT_GB 
        INTO V_FY
           , V_VAT_REPORT_TURN 
           , V_VAT_REPORT_GB 
        FROM FI_VAT_REPORT_MNG VRM
       WHERE VRM.SOB_ID         = W_SOB_ID
         AND VRM.ORG_ID         = W_ORG_ID
         AND VRM.TAX_CODE       = W_TAX_CODE
         AND VRM.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FY := TO_CHAR(W_DEAL_DATE_TO, 'YYYY');
      IF TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN
        V_VAT_REPORT_TURN := '01';
      ELSE
        V_VAT_REPORT_TURN := '02';
      END IF;
      IF TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) IN(3, 9) THEN
        V_VAT_REPORT_GB := '01';
      ELSE
        V_VAT_REPORT_GB := '02';
      END IF;
    END;            
    
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
          /*, TO_CHAR(W_CREATE_DATE, 'YYYY') || '년 ' 
            || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '월 ' 
            || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '일'  AS CREATE_DATE   --작성일자 
          , TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' 년  '
            || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '일  ~  '
            || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '일 ' AS DEAL_TERM    --거레기간*/
          , '(   ' || V_FY || '  년   제 ' ||  
            V_VAT_REPORT_TURN || '  기  ' ||  
            CASE
              WHEN V_VAT_REPORT_GB = '01' THEN '[ V ] 예정   [   ] 확정   )' 
              ELSE '[   ] 예정   [ V ] 확정   )' 
            END AS FISCAL_TITLE   --부가가치세신고기수          
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
  END PRINT_ZERO_RATE_DOCUMENT;

  
END FI_VAT_ZERO_RATE_DOCUMENT_G;
/
