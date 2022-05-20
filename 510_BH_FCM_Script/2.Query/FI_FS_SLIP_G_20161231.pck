CREATE OR REPLACE PACKAGE FI_FS_SLIP_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_SLIP_G
Description  : 재무제표보고서(합계잔액시산표, 제조원가명세서, 손익계산서, 재무상태표_전기이월금액 구할시)에서 
               전표를 근간으로 자료 추출 시 공통으로 이용하는 내부 Package

Reference by : calling assmbly-program id(호출 프로그램) : 제조원가명세서, 손익계산서, 재무상태표의 Package
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-26   Leem Dong Ern(임동언)          
*****************************************************************************/




--전표자료 추출(이용 : 제조원가명세서, 손익계산서)
PROCEDURE CREATE_FS_SLIP( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --항목레벨
    , P_PERIOD_FROM     IN  DATE    --조회시작일
    , P_PERIOD_TO       IN  DATE    --조회종료일
);





--전기이월자료 추출(재무상태표용)
--당기와 전기의 이월금액을 추출한다.
PROCEDURE CREATE_FS_SLIP_BLS( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --항목레벨
    , P_PERIOD_FROM     IN  VARCHAR2    --조회기준년(예>2011)
);







--전기이월자료 추출(합계잔액시산표용)
--당기의 이월금액을 추출한다.
PROCEDURE CREATE_FS_SLIP_BLS_TB( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --항목레벨
    , P_PERIOD_FROM     IN  VARCHAR2    --조회기준년(예>2011)
);






END FI_FS_SLIP_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_SLIP_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_SLIP_G
Description  : 재무제표보고서(합계잔액시산표, 제조원가명세서, 손익계산서, 재무상태표_전기이월금액 구할시)에서 
               전표를 근간으로 자료 추출 시 공통으로 이용하는 내부 Package

Reference by : calling assmbly-program id(호출 프로그램) : 제조원가명세서, 손익계산서, 재무상태표의 Package
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-26   Leem Dong Ern(임동언)          
*****************************************************************************/



--전표자료 추출
PROCEDURE CREATE_FS_SLIP( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE      --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE      --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE   --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE   --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE  --항목레벨
    , P_PERIOD_FROM     IN  DATE    --조회시작일
    , P_PERIOD_TO       IN  DATE    --조회종료일
)

AS
  t_TEMP_AMT            NUMBER := 0;
BEGIN

    --과거 자료 삭제
    DELETE FI_FS_SLIP;
    

    --기준 자료 생성
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --항목코드_계정코드
        , ACCOUNT_CODE  --계정코드
        , DR_AMT        --차변금액
        , CR_AMT        --대변금액
    )
    SELECT  
          ITEM_CODE	        --항목코드_계정코드
        , DET_ITEM_CODE     --상세항목코드
        , 0
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --회사아이디
                    AND ORG_ID          = P_ORG_ID          --사업부아이디
                    AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    

    --각 계정별 차변금액을 UPDATE한다.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            
            --전표분개자료에서 자료 추출 시 전표유형이 '기초잔액이월-BLS'과 '결산대체분개-CRJ'는 제외하고 구한다.
            AND SLIP_TYPE NOT IN ('BLS', 'CRJ') 
            
            AND ACCOUNT_DR_CR = '1' --차대구분(1-차변,2-대변)
            AND GL_DATE BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
            AND ACCOUNT_CODE IN ( SELECT ACCOUNT_CODE FROM FI_FS_SLIP )
        GROUP BY ACCOUNT_CODE
    ) LOOP
        BEGIN
          SELECT NVL(SUM(GL_AMOUNT), 0) AS AMT
            INTO t_TEMP_AMT
            FROM FI_SLIP_LINE
            WHERE SOB_ID          = P_SOB_ID
                AND ORG_ID        = P_ORG_ID
                
                --전표분개자료에서 자료 추출 시 전표유형이 '기초잔액이월-BLS'과 '결산대체분개-CRJ'는 제외하고 구한다.
                AND GL_NUM        = 'CL-20161231-00014'
                AND ACCOUNT_DR_CR = '1' --차대구분(1-차변,2-대변)
                AND GL_DATE       BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
                AND ACCOUNT_CODE  = AMT_REC.ACCOUNT_CODE 
            ;
        EXCEPTION
          WHEN OTHERS THEN
            t_TEMP_AMT := 0;
        END;
        
        UPDATE FI_FS_SLIP
        SET DR_AMT = NVL(AMT_REC.AMT,0) + NVL(t_TEMP_AMT,0) 
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;      
    
    
    --각 계정별 대변금액을 UPDATE한다.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            
            --전표분개자료에서 자료 추출 시 전표유형이 '기초잔액이월-BLS'과 '결산대체분개-CRJ'는 제외하고 구한다.
            AND SLIP_TYPE NOT IN ('BLS', 'CRJ') 
            
            AND ACCOUNT_DR_CR = '2' --차대구분(1-차변,2-대변)
            AND GL_DATE BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
            AND ACCOUNT_CODE IN ( SELECT ACCOUNT_CODE FROM FI_FS_SLIP )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET CR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;      


    
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP;






--전기이월자료 추출(재무상태표용)
--당기와 전기의 이월금액을 추출한다.
PROCEDURE CREATE_FS_SLIP_BLS( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --항목레벨
    , P_PERIOD_FROM     IN  VARCHAR2    --조회기준년(예>2011)
)

AS

BEGIN

    --과거 자료 삭제
    DELETE FI_FS_SLIP;
    

    --기준 자료 생성
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --항목코드_계정코드
        , ACCOUNT_CODE  --계정코드
        , DR_AMT        --당기(예>2011)의 전기이월금액
        , CR_AMT        --전기(예>2010)의 전기이월금액
    )
    SELECT  
          ITEM_CODE	        --항목코드_계정코드
        , DET_ITEM_CODE     --상세항목코드
        , 0
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --회사아이디
                    AND ORG_ID          = P_ORG_ID          --사업부아이디
                    AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    
    --당기(예>2011)의 전기이월금액을 설정한다.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET DR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;
    
    
    --전기(예>2010)의 전기이월금액을 설정한다.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM - 1, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET CR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;    
 
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP_BLS;










--전기이월자료 추출(합계잔액시산표용)
--당기의 이월금액을 추출한다.
PROCEDURE CREATE_FS_SLIP_BLS_TB( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서양식ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --항목레벨
    , P_PERIOD_FROM     IN  VARCHAR2    --조회기준년(예>2011)
)

AS

BEGIN

    --과거 자료 삭제
    DELETE FI_FS_SLIP;
    

    --기준 자료 생성
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --항목코드_계정코드
        , ACCOUNT_CODE  --계정코드
        , DR_AMT        --당기(예>2011)의 전기이월금액
    )
    SELECT  
          ITEM_CODE	        --항목코드_계정코드
        , DET_ITEM_CODE     --상세항목코드
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --회사아이디
                    AND ORG_ID          = P_ORG_ID          --사업부아이디
                    AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    
    --당기(예>2011)의 전기이월금액을 설정한다.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET DR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;   
 
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP_BLS_TB;




END FI_FS_SLIP_G;
/
