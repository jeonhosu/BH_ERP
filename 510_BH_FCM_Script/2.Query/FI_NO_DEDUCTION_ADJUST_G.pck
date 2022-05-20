CREATE OR REPLACE PACKAGE FI_NO_DEDUCTION_ADJUST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_NO_DEDUCTION_ADJUST_G
Description  : 공제받지못할매입세액명세서 내역서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (공제받지못할매입세액명세서)
Program History :
    -.자료 도출 기준 : 거래구분-매입, 세무유형-매입세액불공제
      이는 [매입매출장]프로그램에서 거래구분을 매입으로 세무유형을 매입세액불공제로 조회한 자료와 일치한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2013-09-27   jeon ho su 
*****************************************************************************/


-- 3. 공통매입세액 안분 계산 내역 --
  PROCEDURE SELECT_ADJUST_3
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            );


-- 3. 공통매입세액 안분 계산 INSERT --
  PROCEDURE INSERT_ADJUST_3
            ( P_TAX_CODE           IN  FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , P_SOB_ID             IN  FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , P_ORG_ID             IN  FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , P_VAT_DATE_FR        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , P_NO_DED_TYPE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , P_NO_DED_CODE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , P_NO_DED_DESC        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_DESC%TYPE
            , P_ADJUST_TYPE        IN  FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , P_SEQ_NO             OUT FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN  FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_SUPPLY_AMT         IN  FI_NO_DEDUCTION_ADJUST.SUPPLY_AMT%TYPE
            , P_VAT_AMT            IN  FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN  FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN  FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN  FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN  FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN  FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            );

-- 3. 공통매입세액 안분 계산 Update --
  PROCEDURE UPDATE_ADJUST_3
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_SUPPLY_AMT         IN FI_NO_DEDUCTION_ADJUST.SUPPLY_AMT%TYPE
            , P_VAT_AMT            IN FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            );
                       
-- 3. 공통매입세액 안분 계산 Delete --
  PROCEDURE DELETE_ADJUST_3
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE            
            );
                   

-- 3. 공통매입세액 안분 계산 내역 합계 : 안분후 공급가 --
  PROCEDURE GET_ADJUST_AMOUNT
            ( P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            , O_ADJUST_AMOUNT       OUT NUMBER
            );
                        
            
-- 4. 공통매입세액 정산 내역 --
  PROCEDURE SELECT_ADJUST_4
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            );

-- 4. 공통매입세액 정산 내역 INSERT --
  PROCEDURE INSERT_ADJUST_4
            ( P_TAX_CODE           IN  FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , P_SOB_ID             IN  FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , P_ORG_ID             IN  FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , P_VAT_DATE_FR        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , P_NO_DED_TYPE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , P_NO_DED_CODE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , P_NO_DED_DESC        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_DESC%TYPE
            , P_ADJUST_TYPE        IN  FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , P_SEQ_NO             OUT FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN  FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_VAT_AMT            IN  FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN  FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN  FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN  FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_PRE_VAT_AMT        IN  FI_NO_DEDUCTION_ADJUST.PRE_VAT_AMT%TYPE
            , P_ADDITION_VAT_AMT   IN  FI_NO_DEDUCTION_ADJUST.ADDITION_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN  FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN  FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            );

-- 4. 공통매입세액 정산 내역 Update --
  PROCEDURE UPDATE_ADJUST_4
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_VAT_AMT            IN FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_PRE_VAT_AMT        IN FI_NO_DEDUCTION_ADJUST.PRE_VAT_AMT%TYPE
            , P_ADDITION_VAT_AMT   IN FI_NO_DEDUCTION_ADJUST.ADDITION_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            );
            
-- 4. 공통매입세액 정산 내역 Delete --
  PROCEDURE DELETE_ADJUST_4
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            );
            

-- 3. 공통매입세액 안분 계산 내역 인쇄--
  PROCEDURE PRINT_ADJUST_3
            ( P_CURSOR2             OUT TYPES.TCURSOR2
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            );


-- 4. 공통매입세액 정산 내역 인쇄--
  PROCEDURE PRINT_ADJUST_4
            ( P_CURSOR2             OUT TYPES.TCURSOR2
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            );
                                          
END FI_NO_DEDUCTION_ADJUST_G;
/
CREATE OR REPLACE PACKAGE BODY FI_NO_DEDUCTION_ADJUST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_NO_DEDUCTION_ADJUST_G
Description  : 공제받지못할매입세액명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (공제받지못할매입세액명세서)
Program History :
    -.자료 도출 기준 : 거래구분-매입, 세무유형-매입세액불공제
      이는 [매입매출장]프로그램에서 거래구분을 매입으로 세무유형을 매입세액불공제로 조회한 자료와 일치한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(임동언)
*****************************************************************************/



-- 3. 공통매입세액 안분 계산 내역 --
  PROCEDURE SELECT_ADJUST_3
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DA.SEQ_NO                -- 순서 -- 
           , DA.ADJUST_CALSS          -- 구분 -- 
           , DA.SUPPLY_AMT            -- 과세,면세사업 공통매입액 공급가액 --
           , DA.VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
           , DA.CAL_TYPE              -- 계산식 -- 
           , DA.TAX_SUPPLY_AMT        -- 총공급가액등 -- 
           , DA.NON_TAX_SUPPLY_AMT    -- 면세공급가액등 --
           , DA.NON_TAX_RATE          -- 면세비율(%) -- 
           , DA.NO_VAT_AMT            -- 불공제매입세액 -- 
           , DA.ADJUST_SUPPLY_AMT     -- 안분후 공급가 -- 
        FROM FI_NO_DEDUCTION_ADJUST DA
       WHERE DA.TAX_CODE          = P_TAX_CODE  
         AND DA.SOB_ID            = P_SOB_ID
         AND DA.ORG_ID            = P_ORG_ID
         AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
         AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
         AND DA.NO_DED_TYPE       = P_NO_DED_TYPE
         AND DA.NO_DED_CODE       = P_NO_DED_CODE
         AND DA.ADJUST_TYPE       = P_ADJUST_TYPE
      ORDER BY DA.SEQ_NO
     ;
  END SELECT_ADJUST_3;



-- 3. 공통매입세액 안분 계산 INSERT --
  PROCEDURE INSERT_ADJUST_3
            ( P_TAX_CODE           IN  FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , P_SOB_ID             IN  FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , P_ORG_ID             IN  FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , P_VAT_DATE_FR        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , P_NO_DED_TYPE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , P_NO_DED_CODE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , P_NO_DED_DESC        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_DESC%TYPE
            , P_ADJUST_TYPE        IN  FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , P_SEQ_NO             OUT FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN  FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_SUPPLY_AMT         IN  FI_NO_DEDUCTION_ADJUST.SUPPLY_AMT%TYPE
            , P_VAT_AMT            IN  FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN  FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN  FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN  FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN  FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN  FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    BEGIN
      SELECT NVL(MAX(DA.SEQ_NO), 0) + 1 AS NEXT_SEQ_NO  -- 순서 -- 
        INTO P_SEQ_NO
        FROM FI_NO_DEDUCTION_ADJUST DA
       WHERE DA.TAX_CODE          = P_TAX_CODE  
         AND DA.SOB_ID            = P_SOB_ID
         AND DA.ORG_ID            = P_ORG_ID
         AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
         AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
         AND DA.NO_DED_TYPE       = P_NO_DED_TYPE
         AND DA.NO_DED_CODE       = P_NO_DED_CODE
         AND DA.ADJUST_TYPE       = P_ADJUST_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      P_SEQ_NO := 1;
    END;
    BEGIN
      INSERT INTO FI_NO_DEDUCTION_ADJUST
      ( TAX_CODE
      , SOB_ID 
      , ORG_ID 
      , VAT_DATE_FR 
      , VAT_DATE_TO 
      , NO_DED_TYPE 
      , NO_DED_CODE 
      , NO_DED_DESC 
      , ADJUST_TYPE 
      , SEQ_NO 
      , ADJUST_CALSS 
      , SUPPLY_AMT 
      , VAT_AMT 
      , CAL_TYPE 
      , TAX_SUPPLY_AMT 
      , NON_TAX_SUPPLY_AMT 
      , NON_TAX_RATE 
      , NO_VAT_AMT 
      , ADJUST_SUPPLY_AMT 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_TAX_CODE
      , P_SOB_ID
      , P_ORG_ID
      , P_VAT_DATE_FR
      , P_VAT_DATE_TO
      , P_NO_DED_TYPE
      , P_NO_DED_CODE
      , P_NO_DED_DESC
      , P_ADJUST_TYPE
      , P_SEQ_NO
      , P_ADJUST_CALSS
      , P_SUPPLY_AMT
      , P_VAT_AMT
      , P_CAL_TYPE
      , P_TAX_SUPPLY_AMT
      , P_NON_TAX_SUPPLY_AMT
      , P_NON_TAX_RATE
      , P_NO_VAT_AMT
      , P_ADJUST_SUPPLY_AMT
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END;
  END INSERT_ADJUST_3;

-- 3. 공통매입세액 안분 계산 Update --
  PROCEDURE UPDATE_ADJUST_3
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_SUPPLY_AMT         IN FI_NO_DEDUCTION_ADJUST.SUPPLY_AMT%TYPE
            , P_VAT_AMT            IN FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    BEGIN
      UPDATE  FI_NO_DEDUCTION_ADJUST
          SET ADJUST_CALSS       = P_ADJUST_CALSS
            , SUPPLY_AMT         = P_SUPPLY_AMT
            , VAT_AMT            = P_VAT_AMT
            , CAL_TYPE           = P_CAL_TYPE
            , TAX_SUPPLY_AMT     = P_TAX_SUPPLY_AMT
            , NON_TAX_SUPPLY_AMT = P_NON_TAX_SUPPLY_AMT
            , NON_TAX_RATE       = P_NON_TAX_RATE
            , NO_VAT_AMT         = P_NO_VAT_AMT
            , ADJUST_SUPPLY_AMT  = P_ADJUST_SUPPLY_AMT
            , LAST_UPDATE_DATE   = V_SYSDATE
            , LAST_UPDATED_BY    = P_USER_ID
      WHERE TAX_CODE           = W_TAX_CODE
        AND SOB_ID             = W_SOB_ID
        AND ORG_ID             = W_ORG_ID
        AND VAT_DATE_FR        = W_VAT_DATE_FR
        AND VAT_DATE_TO        = W_VAT_DATE_TO
        AND NO_DED_TYPE        = W_NO_DED_TYPE
        AND NO_DED_CODE        = W_NO_DED_CODE
        AND ADJUST_TYPE        = W_ADJUST_TYPE
        AND SEQ_NO             = W_SEQ_NO;    
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END;
  END UPDATE_ADJUST_3;  

-- 3. 공통매입세액 안분 계산 Delete --
  PROCEDURE DELETE_ADJUST_3
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE            
            )
  AS
  BEGIN
    BEGIN
      DELETE FROM FI_NO_DEDUCTION_ADJUST
        WHERE TAX_CODE           = W_TAX_CODE
          AND SOB_ID             = W_SOB_ID
          AND ORG_ID             = W_ORG_ID
          AND VAT_DATE_FR        = W_VAT_DATE_FR
          AND VAT_DATE_TO        = W_VAT_DATE_TO
          AND NO_DED_TYPE        = W_NO_DED_TYPE
          AND NO_DED_CODE        = W_NO_DED_CODE
          AND ADJUST_TYPE        = W_ADJUST_TYPE
          AND SEQ_NO             = W_SEQ_NO;   
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Delete Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END; 
  END DELETE_ADJUST_3;
  
  
-- 3. 공통매입세액 안분 계산 내역 합계 : 안분후 공급가 --
  PROCEDURE GET_ADJUST_AMOUNT
            ( P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            , O_ADJUST_AMOUNT       OUT NUMBER
            )
  AS
  BEGIN
    BEGIN            
      SELECT NVL(SUM(DA.ADJUST_SUPPLY_AMT), 0) AS ADJUST_SUPPLY_AMT     -- 안분후 공급가 -- 
        INTO O_ADJUST_AMOUNT
        FROM FI_NO_DEDUCTION_ADJUST DA
       WHERE DA.TAX_CODE          = P_TAX_CODE  
         AND DA.SOB_ID            = P_SOB_ID
         AND DA.ORG_ID            = P_ORG_ID
         AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
         AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
         AND DA.NO_DED_TYPE       = P_NO_DED_TYPE
         AND DA.NO_DED_CODE       = P_NO_DED_CODE
         AND DA.ADJUST_TYPE       = P_ADJUST_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ADJUST_AMOUNT := 0;
    END;    
  END GET_ADJUST_AMOUNT;         
            
-- 4. 공통매입세액 정산 내역 --
  PROCEDURE SELECT_ADJUST_4
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            , P_NO_DED_TYPE         IN  VARCHAR2
            , P_NO_DED_CODE         IN  VARCHAR2
            , P_ADJUST_TYPE         IN  VARCHAR2
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DA.SEQ_NO                -- 순서 -- 
           , DA.ADJUST_CALSS          -- 구분 -- 
           , DA.VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
           , DA.CAL_TYPE              -- 계산식 -- 
           , DA.TAX_SUPPLY_AMT        -- 총공급가액등 -- 
           , DA.NON_TAX_SUPPLY_AMT    -- 면세공급가액등 --
           , DA.NON_TAX_RATE          -- 면세비율(%) -- 
           , DA.NO_VAT_AMT            -- 불공제매입세액 -- 
           , DA.PRE_VAT_AMT           -- 기불공제매입세액 --
           , DA.ADDITION_VAT_AMT      -- 가산또는 공제 매입세액 --            
           , DA.ADJUST_SUPPLY_AMT     -- 정산후 공급가 -- 
        FROM FI_NO_DEDUCTION_ADJUST DA
       WHERE DA.TAX_CODE          = P_TAX_CODE  
         AND DA.SOB_ID            = P_SOB_ID
         AND DA.ORG_ID            = P_ORG_ID
         AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
         AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
         AND DA.NO_DED_TYPE       = P_NO_DED_TYPE
         AND DA.NO_DED_CODE       = P_NO_DED_CODE
         AND DA.ADJUST_TYPE       = P_ADJUST_TYPE
      ORDER BY DA.SEQ_NO
     ;
  END SELECT_ADJUST_4;
  
-- 4. 공통매입세액 정산 내역 INSERT --
  PROCEDURE INSERT_ADJUST_4
            ( P_TAX_CODE           IN  FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , P_SOB_ID             IN  FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , P_ORG_ID             IN  FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , P_VAT_DATE_FR        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO        IN  FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , P_NO_DED_TYPE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , P_NO_DED_CODE        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , P_NO_DED_DESC        IN  FI_NO_DEDUCTION_ADJUST.NO_DED_DESC%TYPE
            , P_ADJUST_TYPE        IN  FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , P_SEQ_NO             OUT FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN  FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_VAT_AMT            IN  FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN  FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN  FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN  FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN  FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_PRE_VAT_AMT        IN  FI_NO_DEDUCTION_ADJUST.PRE_VAT_AMT%TYPE
            , P_ADDITION_VAT_AMT   IN  FI_NO_DEDUCTION_ADJUST.ADDITION_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN  FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN  FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    BEGIN
      SELECT NVL(MAX(DA.SEQ_NO), 0) + 1 AS NEXT_SEQ_NO  -- 순서 -- 
        INTO P_SEQ_NO
        FROM FI_NO_DEDUCTION_ADJUST DA
       WHERE DA.TAX_CODE          = P_TAX_CODE  
         AND DA.SOB_ID            = P_SOB_ID
         AND DA.ORG_ID            = P_ORG_ID
         AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
         AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
         AND DA.NO_DED_TYPE       = P_NO_DED_TYPE
         AND DA.NO_DED_CODE       = P_NO_DED_CODE
         AND DA.ADJUST_TYPE       = P_ADJUST_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      P_SEQ_NO := 1;
    END;
    BEGIN
      INSERT INTO FI_NO_DEDUCTION_ADJUST
      ( TAX_CODE
      , SOB_ID 
      , ORG_ID 
      , VAT_DATE_FR 
      , VAT_DATE_TO 
      , NO_DED_TYPE 
      , NO_DED_CODE 
      , NO_DED_DESC 
      , ADJUST_TYPE 
      , SEQ_NO 
      , ADJUST_CALSS 
      , VAT_AMT 
      , CAL_TYPE 
      , TAX_SUPPLY_AMT 
      , NON_TAX_SUPPLY_AMT 
      , NON_TAX_RATE 
      , NO_VAT_AMT 
      , PRE_VAT_AMT 
      , ADDITION_VAT_AMT 
      , ADJUST_SUPPLY_AMT 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_TAX_CODE
      , P_SOB_ID
      , P_ORG_ID
      , P_VAT_DATE_FR
      , P_VAT_DATE_TO
      , P_NO_DED_TYPE
      , P_NO_DED_CODE
      , P_NO_DED_DESC
      , P_ADJUST_TYPE
      , P_SEQ_NO
      , P_ADJUST_CALSS
      , P_VAT_AMT
      , P_CAL_TYPE
      , P_TAX_SUPPLY_AMT
      , P_NON_TAX_SUPPLY_AMT
      , P_NON_TAX_RATE
      , P_NO_VAT_AMT
      , P_PRE_VAT_AMT
      , P_ADDITION_VAT_AMT
      , P_ADJUST_SUPPLY_AMT
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END;
  END INSERT_ADJUST_4;

-- 4. 공통매입세액 정산 내역 Update --
  PROCEDURE UPDATE_ADJUST_4
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            , P_ADJUST_CALSS       IN FI_NO_DEDUCTION_ADJUST.ADJUST_CALSS%TYPE
            , P_VAT_AMT            IN FI_NO_DEDUCTION_ADJUST.VAT_AMT%TYPE
            , P_CAL_TYPE           IN FI_NO_DEDUCTION_ADJUST.CAL_TYPE%TYPE
            , P_TAX_SUPPLY_AMT     IN FI_NO_DEDUCTION_ADJUST.TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_SUPPLY_AMT IN FI_NO_DEDUCTION_ADJUST.NON_TAX_SUPPLY_AMT%TYPE
            , P_NON_TAX_RATE       IN FI_NO_DEDUCTION_ADJUST.NON_TAX_RATE%TYPE
            , P_NO_VAT_AMT         IN FI_NO_DEDUCTION_ADJUST.NO_VAT_AMT%TYPE
            , P_PRE_VAT_AMT        IN FI_NO_DEDUCTION_ADJUST.PRE_VAT_AMT%TYPE
            , P_ADDITION_VAT_AMT   IN FI_NO_DEDUCTION_ADJUST.ADDITION_VAT_AMT%TYPE
            , P_ADJUST_SUPPLY_AMT  IN FI_NO_DEDUCTION_ADJUST.ADJUST_SUPPLY_AMT%TYPE
            , P_USER_ID            IN FI_NO_DEDUCTION_ADJUST.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    BEGIN
      UPDATE  FI_NO_DEDUCTION_ADJUST
          SET ADJUST_CALSS       = P_ADJUST_CALSS
            , VAT_AMT            = P_VAT_AMT
            , CAL_TYPE           = P_CAL_TYPE
            , TAX_SUPPLY_AMT     = P_TAX_SUPPLY_AMT
            , NON_TAX_SUPPLY_AMT = P_NON_TAX_SUPPLY_AMT
            , NON_TAX_RATE       = P_NON_TAX_RATE
            , NO_VAT_AMT         = P_NO_VAT_AMT
            , PRE_VAT_AMT        = P_PRE_VAT_AMT
            , ADDITION_VAT_AMT   = P_ADDITION_VAT_AMT
            , ADJUST_SUPPLY_AMT  = P_ADJUST_SUPPLY_AMT
            , LAST_UPDATE_DATE   = V_SYSDATE
            , LAST_UPDATED_BY    = P_USER_ID
      WHERE TAX_CODE           = W_TAX_CODE
        AND SOB_ID             = W_SOB_ID
        AND ORG_ID             = W_ORG_ID
        AND VAT_DATE_FR        = W_VAT_DATE_FR
        AND VAT_DATE_TO        = W_VAT_DATE_TO
        AND NO_DED_TYPE        = W_NO_DED_TYPE
        AND NO_DED_CODE        = W_NO_DED_CODE
        AND ADJUST_TYPE        = W_ADJUST_TYPE
        AND SEQ_NO             = W_SEQ_NO;  
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END;  
  END UPDATE_ADJUST_4;
            
-- 4. 공통매입세액 정산 내역 Delete --
  PROCEDURE DELETE_ADJUST_4
            ( W_TAX_CODE           IN FI_NO_DEDUCTION_ADJUST.TAX_CODE%TYPE
            , W_SOB_ID             IN FI_NO_DEDUCTION_ADJUST.SOB_ID%TYPE
            , W_ORG_ID             IN FI_NO_DEDUCTION_ADJUST.ORG_ID%TYPE
            , W_VAT_DATE_FR        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO        IN FI_NO_DEDUCTION_ADJUST.VAT_DATE_TO%TYPE
            , W_NO_DED_TYPE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_TYPE%TYPE
            , W_NO_DED_CODE        IN FI_NO_DEDUCTION_ADJUST.NO_DED_CODE%TYPE
            , W_ADJUST_TYPE        IN FI_NO_DEDUCTION_ADJUST.ADJUST_TYPE%TYPE
            , W_SEQ_NO             IN FI_NO_DEDUCTION_ADJUST.SEQ_NO%TYPE
            )
  AS
  BEGIN
    BEGIN
      DELETE FROM FI_NO_DEDUCTION_ADJUST
      WHERE TAX_CODE           = W_TAX_CODE
        AND SOB_ID             = W_SOB_ID
        AND ORG_ID             = W_ORG_ID
        AND VAT_DATE_FR        = W_VAT_DATE_FR
        AND VAT_DATE_TO        = W_VAT_DATE_TO
        AND NO_DED_TYPE        = W_NO_DED_TYPE
        AND NO_DED_CODE        = W_NO_DED_CODE
        AND ADJUST_TYPE        = W_ADJUST_TYPE
        AND SEQ_NO             = W_SEQ_NO;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Delete Error : ' || SUBSTR(SQLERRM, 1, 200));
      RETURN;
    END;    
  END DELETE_ADJUST_4;
              

-- 3. 공통매입세액 안분 계산 내역 인쇄--
  PROCEDURE PRINT_ADJUST_3
            ( P_CURSOR2             OUT TYPES.TCURSOR2
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            )
  AS
    V_NO_DED_TYPE       VARCHAR2(10) := '20'; 
    V_NO_DED_CODE       VARCHAR2(10) := '110'; 
    V_ADJUST_TYPE       VARCHAR2(10) := '3'; 
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SX1.SEQ_NO                -- 순서 -- 
           , SX1.SUPPLY_AMT            -- 과세,면세사업 공통매입액 공급가액 --
           , SX1.VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
           , SX1.TAX_SUPPLY_AMT        -- 총공급가액등 -- 
           , SX1.NON_TAX_SUPPLY_AMT    -- 면세공급가액등 --
           , SX1.NO_VAT_AMT            -- 불공제매입세액 -- 
        FROM (SELECT DA.SEQ_NO                -- 순서 -- 
                   , DA.SUPPLY_AMT            -- 과세,면세사업 공통매입액 공급가액 --
                   , DA.VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
                   , DA.TAX_SUPPLY_AMT        -- 총공급가액등 -- 
                   , DA.NON_TAX_SUPPLY_AMT    -- 면세공급가액등 --
                   , DA.NO_VAT_AMT            -- 불공제매입세액 -- 
                FROM FI_NO_DEDUCTION_ADJUST DA
               WHERE DA.TAX_CODE          = P_TAX_CODE  
                 AND DA.SOB_ID            = P_SOB_ID
                 AND DA.ORG_ID            = P_ORG_ID
                 AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
                 AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
                 AND DA.NO_DED_TYPE       = V_NO_DED_TYPE  -- '20'  --
                 AND DA.NO_DED_CODE       = V_NO_DED_CODE  -- '110' --
                 AND DA.ADJUST_TYPE       = V_ADJUST_TYPE  -- '3' --          
                 AND DA.SEQ_NO            <= 5
              UNION ALL
              SELECT 99 AS SEQ_NO              -- 순서 -- 
                   , SUM(DA.SUPPLY_AMT) AS SUPPLY_AMT            -- 과세,면세사업 공통매입액 공급가액 --
                   , SUM(DA.VAT_AMT) AS VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
                   , TO_NUMBER(NULL) AS TAX_SUPPLY_AMT       -- 총공급가액등 -- 
                   , TO_NUMBER(NULL) AS NON_TAX_SUPPLY_AMT    -- 면세공급가액등 --
                   , SUM(DA.NO_VAT_AMT) AS NO_VAT_AMT            -- 불공제매입세액 --
                FROM FI_NO_DEDUCTION_ADJUST DA
               WHERE DA.TAX_CODE          = P_TAX_CODE  
                 AND DA.SOB_ID            = P_SOB_ID
                 AND DA.ORG_ID            = P_ORG_ID
                 AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
                 AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
                 AND DA.NO_DED_TYPE       = V_NO_DED_TYPE  -- '20'  --
                 AND DA.NO_DED_CODE       = V_NO_DED_CODE  -- '110' --
                 AND DA.ADJUST_TYPE       = V_ADJUST_TYPE  -- '3' --          
            ) SX1
       ORDER BY SX1.SEQ_NO    
      ;               
  END PRINT_ADJUST_3;
  

-- 4. 공통매입세액 정산 내역 인쇄--
  PROCEDURE PRINT_ADJUST_4
            ( P_CURSOR2             OUT TYPES.TCURSOR2
            , P_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
            , P_SOB_ID              IN  NUMBER  --회사아이디
            , P_ORG_ID              IN  NUMBER  --사업부아이디
            , P_VAT_DATE_FR         IN  DATE    --신고기간_시작
            , P_VAT_DATE_TO         IN  DATE    --신고기간_종료
            )
  AS
    V_NO_DED_TYPE       VARCHAR2(10) := '20'; 
    V_NO_DED_CODE       VARCHAR2(10) := '120'; 
    V_ADJUST_TYPE       VARCHAR2(10) := '4'; 
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SX1.SEQ_NO                -- 순서 -- 
           , SX1.VAT_AMT               -- 과세면세사업등 총공통매입세액  --
           , SX1.NON_TAX_RATE          -- 면세비율등(%)  --
           , SX1.NO_VAT_AMT            -- 불공제매입세액  -- 
           , SX1.PRE_VAT_AMT           -- 기공제매입세액  --
           , SX1.ADDITION_VAT_AMT      -- 가산또는공제매입세액  -- 
        FROM (SELECT DA.SEQ_NO                -- 순서 -- 
                   , DA.VAT_AMT               -- 과세,면세사업 공통매입액 세액 --
                   , DA.NON_TAX_RATE          -- 면세비율등(%) -- 
                   , DA.NO_VAT_AMT            -- 불공제매입세액 -- 
                   , DA.PRE_VAT_AMT           -- 기불공제 매입세액 -- 
                   , DA.ADDITION_VAT_AMT      -- 가산또는공제매입세액 -- 
                FROM FI_NO_DEDUCTION_ADJUST DA
               WHERE DA.TAX_CODE          = P_TAX_CODE  
                 AND DA.SOB_ID            = P_SOB_ID
                 AND DA.ORG_ID            = P_ORG_ID
                 AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
                 AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
                 AND DA.NO_DED_TYPE       = V_NO_DED_TYPE  -- '20'  --
                 AND DA.NO_DED_CODE       = V_NO_DED_CODE  -- '120' --
                 AND DA.ADJUST_TYPE       = V_ADJUST_TYPE  -- '4' --          
                 AND DA.SEQ_NO            <= 2
              UNION ALL
              SELECT 99 AS SEQ_NO              -- 순서 -- 
                   , TO_NUMBER(NULL) AS VAT_AMT                     -- 과세면세사업등 총공통매입세액  --
                   , TO_NUMBER(NULL) AS NON_TAX_RATE                -- 면세비율등(%)  --
                   , SUM(DA.NO_VAT_AMT) AS NO_VAT_AMT               -- 불공제매입세액  -- 
                   , SUM(DA.PRE_VAT_AMT) AS PRE_VAT_AMT             -- 기불공제 매입세액  --
                   , SUM(DA.ADDITION_VAT_AMT) AS ADDITION_VAT_AMT   -- 가산또는공제매입세액  --
                FROM FI_NO_DEDUCTION_ADJUST DA
               WHERE DA.TAX_CODE          = P_TAX_CODE  
                 AND DA.SOB_ID            = P_SOB_ID
                 AND DA.ORG_ID            = P_ORG_ID
                 AND DA.VAT_DATE_FR       = P_VAT_DATE_FR
                 AND DA.VAT_DATE_TO       = P_VAT_DATE_TO
                 AND DA.NO_DED_TYPE       = V_NO_DED_TYPE  -- '20'  --
                 AND DA.NO_DED_CODE       = V_NO_DED_CODE  -- '120' --
                 AND DA.ADJUST_TYPE       = V_ADJUST_TYPE  -- '4' --          
            ) SX1
       ORDER BY SX1.SEQ_NO    
      ;               
  END PRINT_ADJUST_4;
  
    
END FI_NO_DEDUCTION_ADJUST_G;
/
