CREATE OR REPLACE PACKAGE FI_FORWARD_AMT_G
AS



/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORWARD_AMT_G
Description  : 기말차기이월작업 Package

Reference by : calling assmbly-program id(호출 프로그램) : 
Program History : 재무상태표의 금액이 차기로 이월될 금액이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-12-16   Leem Dong Ern(임동언)          
*****************************************************************************/




--이월기초자료생성
PROCEDURE CREATE_FORWARD_AMT(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    --, W_DEPT_ID         IN FI_FORWARD_AMT.DEPT_ID%TYPE      --발의부서
    , W_USER_ID       IN FI_FORWARD_AMT.PERSON_ID%TYPE    --발의자
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.
);




--관리항목명을 수정할 수 있는 관리항목인지 여부를 파악하여 해당하는 항목명 구분문자를 넘긴다.
--이 PROCEDURE는 [관리항목별원장조회 : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] 프로그램의 것을 차용한 것이다.
--CREATE_FORWARD_AMT PROCEDURE에서 내부적으로 사용한다.
FUNCTION MANAGEMENT_UPD_YN_F( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_COMMON_ID       IN FI_COMMON.COMMON_ID%TYPE         --공통코드 ID
) RETURN VARCHAR2;




--관리항목명 수정
--이 PROCEDURE는 [관리항목별원장조회 : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] 프로그램의 것을 차용한 것이다.
--CREATE_FORWARD_AMT PROCEDURE에서 내부적으로 사용한다.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    
    --계정통제아이디; 계정코드를 사용하는 것과 동일한 것안데 편의상 아이디를 이용했을 뿐이다.
    , W_ACCOUNT_CONTROL_ID  IN FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE --계정통제아이디
    
    , W_COLUMN              IN  VARCHAR2    --수정할 칼럼명
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
);









--차기이월금액 조회(계정별)
PROCEDURE LIST_FORWARD_AMT_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
);





--차기이월금액 조회(상세항목별)
PROCEDURE LIST_FORWARD_AMT_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
);





--차기이월실행
--전표 테이블에 차기이월금액을 INSERT하는 것이다.
--전표유형 : BLS(기초잔액)

--참조>전표테이블에 자료 INSERT하는 것에 대한 주석
--하기의 일반적인 전표생성 방법은 감가상각전표생성하는 것 등을 생각하면 된다.
--일반적인 전표생성 방법과 본 차기이월자료를 전표테이블에 INSERT 하는 방법에는 약간의 논리적 차이가 있다.
--일반적인 전표 생성시에는 정합성 체크를 위해 FI_SLIP_G.INSERT_SLIP_HEADER 또는 FI_SLIP_G.INSERT_SLIP_LINE의 PROCEDURE를
--호출하지만, 차기이월자료 생성시에는 전표가 아니기에 전표관련 2 테이블에 해당 자료를 직접 INSERT한다.
PROCEDURE CREATE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.
);






--전표테이블(FI_SLIP_HEADER, FI_SLIP_LINE)에 등록된 차기이월자료삭제
--참조>이 삭제는 본 로직을 통해 생성된 이월자료만을 삭제한다. 
--행여 본 로직이 아닌 다른 방법(기존에 있던 기초잔액등록 프로그램을 이용)으로 추가된 이월자료는 삭제하지 않는다.
PROCEDURE DELETE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    , W_GL_NUM          IN FI_FORWARD_AMT.GL_NUM%TYPE       --회계번호
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.
);







END FI_FORWARD_AMT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORWARD_AMT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORWARD_AMT_G
Description  : 기말차기이월작업 Package

Reference by : calling assmbly-program id(호출 프로그램) : 
Program History : 재무상태표의 금액이 차기로 이월될 금액이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-12-16   Leem Dong Ern(임동언)          
*****************************************************************************/





--이월기초자료생성
PROCEDURE CREATE_FORWARD_AMT(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    --, W_DEPT_ID         IN FI_FORWARD_AMT.DEPT_ID%TYPE      --발의부서
    , W_USER_ID       IN FI_FORWARD_AMT.PERSON_ID%TYPE    --발의자
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.
)


AS

REC_CREATE  EXCEPTION;


t_DEPT_ID       NUMBER; --발의부서
t_PERSON_ID     NUMBER; --발의자

V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);   --현재일자

t_ACCOUNT_CONTROL_ID    FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE;	    --계정통제아이디

t_REFER1_ID     FI_ACCOUNT_CONTROL.REFER1_ID%TYPE;	    --관리항목아이디1
t_REFER2_ID     FI_ACCOUNT_CONTROL.REFER2_ID%TYPE;	    --관리항목아이디2
t_REFER3_ID     FI_ACCOUNT_CONTROL.REFER3_ID%TYPE;	    --관리항목아이디3
t_REFER4_ID     FI_ACCOUNT_CONTROL.REFER4_ID%TYPE;	    --관리항목아이디4
t_REFER5_ID     FI_ACCOUNT_CONTROL.REFER5_ID%TYPE;	    --관리항목아이디5
t_REFER6_ID     FI_ACCOUNT_CONTROL.REFER6_ID%TYPE;	    --관리항목아이디6
t_REFER7_ID     FI_ACCOUNT_CONTROL.REFER7_ID%TYPE;	    --관리항목아이디7
t_REFER8_ID     FI_ACCOUNT_CONTROL.REFER8_ID%TYPE;	    --관리항목아이디8
t_REFER9_ID     FI_ACCOUNT_CONTROL.REFER9_ID%TYPE;	    --관리항목아이디9
t_REFER10_ID    FI_ACCOUNT_CONTROL.REFER10_ID%TYPE;	--관리항목아이디10
t_REFER11_ID    FI_ACCOUNT_CONTROL.REFER11_ID%TYPE;	--관리항목아이디11
t_REFER12_ID    FI_ACCOUNT_CONTROL.REFER12_ID%TYPE;	--관리항목아이디12
t_REFER13_ID    FI_ACCOUNT_CONTROL.REFER13_ID%TYPE;	--관리항목아이디13
t_REFER14_ID    FI_ACCOUNT_CONTROL.REFER14_ID%TYPE;	--관리항목아이디14
t_REFER15_ID    FI_ACCOUNT_CONTROL.REFER15_ID%TYPE;	--관리항목아이디15 

t_MANAGEMENT_GUBUN  FI_COMMON.CODE_NAME%TYPE;	--공통코드명 


--아래 변수들은 미처분이익잉여금 계정 값을 보정할 시에 사용한다.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;

t_THIS_NON_LAST_AMT     NUMBER  := 0;   --당기순이익

t_CNT NUMBER  := 0;   --이월이익잉여금 자료 파악


BEGIN



    --차기이월자료가 이미 생성되어 있다면 이월기초자료를 생성할 수 없다.
    --차기이월자료가 이미 생성되어 있는지를 파악한다.
    --차기이월할 자료에 전표번호가 있다는 것은 본 프로시져를 실행한 결과 차기이월자료가 이미 생성되었다는 뜻이다.
    BEGIN
      SELECT COUNT(*)
      INTO t_CNT
      FROM FI_FORWARD_AMT
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND FORWARD_YEAR = W_FORWARD_YEAR
          AND GL_NUM IS NOT NULL  ;
    EXCEPTION WHEN OTHERS THEN
      t_CNT := 0;
    END;


        
    IF t_CNT > 0 THEN
        --FCM_10430 : 기 생성한 차기이월 자료를 삭제 후 작업바랍니다.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL); 
        RETURN;
        --FCM_10430 : 기 생성한 차기이월 자료를 삭제 후 작업바랍니다.
        --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL);      
    END IF;




    --차기이월하려는 년도의 기존 자료를 삭제한다.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
    ;


--본 쿼리는 아래 1, 2번에 의해 추출되는 계정을 구하기 위한 원 문장이다.
/*

SELECT
      ACCOUNT_CODE  --계정코드
    , ACCOUNT_DESC  --계정명
    , ACCOUNT_DR_CR --차대구분(0-차, 1-대)
    , ACCOUNT_CLASS_CODE    --계정타입_코드
    , ACCOUNT_CLASS         --계정타입_명
FROM
    (
        SELECT
              A.DET_ITEM_CODE AS ACCOUNT_CODE   --상세항목코드  
            , C.ACCOUNT_DESC
            , C.ACCOUNT_DR_CR
            , CASE
                WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                        IN ('140', '150', '160', '170', '180') 
                        THEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                ELSE NULL
              END AS ACCOUNT_CLASS_CODE
            , FI_COMMON_G.ID_NAME_F(
                CASE
                    WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                        IN ('140', '150', '160', '170', '180') THEN C.ACCOUNT_CLASS_ID
                    ELSE NULL
                END
              ) AS ACCOUNT_CLASS    --계정타입
        FROM FI_FORM_DET A, FI_FORM_MST B, 
            ( SELECT * FROM FI_ACCOUNT_CONTROL WHERE SOB_ID = 10 AND ORG_ID = 101) C
        WHERE B.SOB_ID = 10
            AND B.ORG_ID = 101
            AND B.FS_SET_ID = 1674  --재무제표양식세트
            AND B.FORM_TYPE_ID = 745    --보고서양식
            AND B.ITEM_LEVEL = 
                    (
                        SELECT MAX(ITEM_LEVEL)
                        FROM FI_FORM_MST
                        WHERE SOB_ID = 10
                            AND ORG_ID = 101
                            AND FS_SET_ID = 1674  --재무제표양식세트
                            AND FORM_TYPE_ID = 745    --보고서양식            
                    )    
            
            AND B.SOB_ID = A.SOB_ID(+)
            AND B.ORG_ID = A.ORG_ID(+)
            AND B.FS_SET_ID = A.FS_SET_ID(+)
            AND B.FORM_TYPE_ID = A.FORM_TYPE_ID(+)
            
            AND B.ITEM_CODE = A.ITEM_CODE
            AND A.DET_ITEM_CODE = C.ACCOUNT_CODE
    )
WHERE ACCOUNT_CLASS_CODE IS NULL 
    AND ACCOUNT_CODE NOT IN ('1111700', '2100700')
    OR ACCOUNT_CLASS_CODE != '150'
--계정타입이 [차기이월시 귀속계정]인 계정은 [차기이월시 대표계정]으로 가감되어 이월되므로 이월자료에서 제외한 것이다.
--또한 [부가세예수금, 부가세대급금]은 이월시 잔액이 남을 수 가 없는 계정인데, 이월의 대 기준인 관리항목으로 봐서는 
--그 수가 많으므로 제외했다.
ORDER BY ACCOUNT_CODE
*/



    --발의부서, 발의자 설정
    --아래의 SELECT문구는 마음에 들지는 않지만 기존에 있는 QUERY를 그대로 사용했다.
    BEGIN
        SELECT EU.PERSON_ID, DM.M_DEPT_ID
        INTO t_PERSON_ID, t_DEPT_ID
        FROM EAPP_USER EU
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
        WHERE EU.PERSON_ID  = PM.PERSON_ID(+)
        AND PM.DEPT_ID      = DM.HR_DEPT_ID(+)
        AND EU.USER_ID      = W_USER_ID
        AND EU.SOB_ID       = W_SOB_ID
        ;
    EXCEPTION 
        WHEN OTHERS THEN
            NULL;
    END;



--1.일반적인 경우
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자    
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --차기이월년도
        , W_SOB_ID AS SOB_ID    --회사아이디
        , W_ORG_ID AS ORG_ID    --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --회계일자
        , t_DEPT_ID --발의부서
        , t_PERSON_ID AS PERSON_ID  --발의자
        , 'BLS' AS SLIP_TYPE    --전표유형(기초잔액)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --계정통제아이디
        , A.ACCOUNT_CODE    --계정코드
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --차대구분(0-차, 1-대)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
          END REMAIN_AMT    --이월금액
          
        , 'KRW' AS CURRENCY_CODE --통화
        , 0 AS EXCHANGE_RATE    --환율
        , 0 AS GL_CURRENCY_AMOUNT   --외화금액
        , A.MANAGEMENT1 --관리항목1
        , A.MANAGEMENT2 --관리항목2
        , A.REFER1  --관리항목3
        , A.REFER2  --관리항목4
        , A.REFER3  --관리항목5
        , A.REFER4  --관리항목6
        , A.REFER5  --관리항목7
        , A.REFER6  --관리항목8
        , A.REFER7  --관리항목9
        , A.REFER8  --관리항목10
        , A.REFER9  --관리항목11
        , A.REFER10 --관리항목12
        , A.REFER11 --관리항목13
        , A.REFER12 --관리항목14
        , A.REFER13 --관리항목15
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --적요
        , V_SYSDATE AS CREATION_DATE	--생성일
        , t_PERSON_ID AS CREATED_BY	--생성자
        , V_SYSDATE AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID AS LAST_UPDATED_BY	--수정자 
    FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))

        --이 줄을 주석으로 처리한 이유는 향후 계정으로 무언가의 테스트를 할 필요가 있을 경우를 대비하기 위함이다.
        --AND A.ACCOUNT_CODE = '1110900'            
        AND A.ACCOUNT_CODE IN
            (
                SELECT ACCOUNT_CODE  --계정코드
                FROM
                    (   --기본골격이다.
                        SELECT
                              A.DET_ITEM_CODE AS ACCOUNT_CODE   --상세항목코드  
                            , C.ACCOUNT_DESC
                            , CASE
                                WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                        IN ('140', '150', '160', '170', '180') 
                                        THEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                ELSE NULL
                              END AS ACCOUNT_CLASS_CODE
                            , FI_COMMON_G.ID_NAME_F(
                                CASE
                                    WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                        IN ('140', '150', '160', '170', '180') THEN C.ACCOUNT_CLASS_ID
                                    ELSE NULL
                                END
                              ) AS ACCOUNT_CLASS    --계정타입
                        FROM FI_FORM_DET A, FI_FORM_MST B, 
                            ( SELECT * FROM FI_ACCOUNT_CONTROL WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID) C
                        WHERE B.SOB_ID = W_SOB_ID
                            AND B.ORG_ID = W_ORG_ID
                            AND B.FS_SET_ID = 1674  --재무제표양식세트(K-GAAP)
                            AND B.FORM_TYPE_ID = 745    --보고서양식(재무상태표)
                            AND B.ITEM_LEVEL = 
                                    (
                                        SELECT MAX(ITEM_LEVEL)
                                        FROM FI_FORM_MST
                                        WHERE SOB_ID = W_SOB_ID
                                            AND ORG_ID = W_ORG_ID
                                            AND FS_SET_ID = 1674  --재무제표양식세트(K-GAAP)
                                            AND FORM_TYPE_ID = 745    --보고서양식(재무상태표)            
                                    )    
                            
                            AND B.SOB_ID = A.SOB_ID(+)
                            AND B.ORG_ID = A.ORG_ID(+)
                            AND B.FS_SET_ID = A.FS_SET_ID(+)
                            AND B.FORM_TYPE_ID = A.FORM_TYPE_ID(+)
                            
                            AND B.ITEM_CODE = A.ITEM_CODE
                            AND A.DET_ITEM_CODE = C.ACCOUNT_CODE
                    )
                WHERE ACCOUNT_CLASS_CODE IS NULL                
                    AND ACCOUNT_CODE NOT IN ('1111700', '2100700')  --[부가세예수금, 부가세대급금] 게정제외       
            )
              
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
        , A.MANAGEMENT1
        , A.MANAGEMENT2
        , A.REFER1
        , A.REFER2
        , A.REFER3
        , A.REFER4
        , A.REFER5
        , A.REFER6
        , A.REFER7
        , A.REFER8
        , A.REFER9
        , A.REFER10
        , A.REFER11
        , A.REFER12
        , A.REFER13        
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '1.' || SQLERRM;
            RETURN;
  END;


--2.특별한 경우[계정타입이 있는 경우]

--2-1. 160 : 차기이월시 잔액만
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자    
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --차기이월년도
        , W_SOB_ID AS SOB_ID    --회사아이디
        , W_ORG_ID AS ORG_ID    --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --회계일자
        , t_DEPT_ID --발의부서
        , t_PERSON_ID AS PERSON_ID  --발의자
        , 'BLS' AS SLIP_TYPE    --전표유형(기초잔액)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --계정통제아이디
        , A.ACCOUNT_CODE    --계정코드
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --차대구분(0-차, 1-대)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
          END REMAIN_AMT    --이월금액
          
        , 'KRW' AS CURRENCY_CODE --통화
        , 0 AS EXCHANGE_RATE    --환율
        , 0 AS GL_CURRENCY_AMOUNT   --외화금액
        
        , NULL AS MANAGEMENT1 --관리항목1
        , NULL AS MANAGEMENT2 --관리항목2
        , NULL AS REFER1  --관리항목3
        , NULL AS REFER2  --관리항목4
        , NULL AS REFER3  --관리항목5
        , NULL AS REFER4  --관리항목6
        , NULL AS REFER5  --관리항목7
        , NULL AS REFER6  --관리항목8
        , NULL AS REFER7  --관리항목9
        , NULL AS REFER8  --관리항목10
        , NULL AS REFER9  --관리항목11
        , NULL AS REFER10 --관리항목12
        , NULL AS REFER11 --관리항목13
        , NULL AS REFER12 --관리항목14
        , NULL AS REFER13 --관리항목15    
        
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --적요
        , V_SYSDATE AS CREATION_DATE	--생성일
        , t_PERSON_ID AS CREATED_BY	--생성자
        , V_SYSDATE AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID AS LAST_UPDATED_BY	--수정자 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '160'   --160(차기이월시 잔액만)                
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110100'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '2.' || SQLERRM;
            RETURN;
  END;

--2-2. 170 : 차기이월시 통화코드별로
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --차기이월년도
        , W_SOB_ID AS SOB_ID    --회사아이디
        , W_ORG_ID AS ORG_ID    --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --회계일자
        , t_DEPT_ID --발의부서
        , t_PERSON_ID AS PERSON_ID  --발의자
        , 'BLS' AS SLIP_TYPE    --전표유형(기초잔액)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --계정통제아이디
        , A.ACCOUNT_CODE    --계정코드
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --차대구분(0-차, 1-대)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
          END REMAIN_AMT    --이월금액
          
        , A.CURRENCY_CODE AS CURRENCY_CODE --통화
        , 0 AS EXCHANGE_RATE    --환율
        , 0 AS GL_CURRENCY_AMOUNT   --외화금액
        
        , NULL AS MANAGEMENT1 --관리항목1
        , NULL AS MANAGEMENT2 --관리항목2
        , NULL AS REFER1  --관리항목3
        , NULL AS REFER2  --관리항목4
        , NULL AS REFER3  --관리항목5
        , NULL AS REFER4  --관리항목6
        , NULL AS REFER5  --관리항목7
        , NULL AS REFER6  --관리항목8
        , NULL AS REFER7  --관리항목9
        , NULL AS REFER8  --관리항목10
        , NULL AS REFER9  --관리항목11
        , NULL AS REFER10 --관리항목12
        , NULL AS REFER11 --관리항목13
        , NULL AS REFER12 --관리항목14
        , NULL AS REFER13 --관리항목15    
        
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --적요
        , V_SYSDATE AS CREATION_DATE	--생성일
        , t_PERSON_ID AS CREATED_BY	--생성자
        , V_SYSDATE AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID AS LAST_UPDATED_BY	--수정자 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '170'   --170(차기이월시 통화코드별로)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110200'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE, A.CURRENCY_CODE
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '3.' || SQLERRM;
            RETURN;
  END;



--2-3. 140 : 차기이월시 대표계정
  BEGIN
    --2-3-1.이 문장으로 기본 자료를 만들고,
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --차기이월년도
        , W_SOB_ID AS SOB_ID    --회사아이디
        , W_ORG_ID AS ORG_ID    --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --회계일자
        , t_DEPT_ID --발의부서
        , t_PERSON_ID AS PERSON_ID  --발의자
        , 'BLS' AS SLIP_TYPE    --전표유형(기초잔액)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --계정통제아이디
        , A.ACCOUNT_CODE    --계정코드
        , (B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --차대구분(0-차, 1-대)
        
        , CASE (B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
          END REMAIN_AMT    --이월금액
          
        , 'KRW' AS CURRENCY_CODE --통화
        , 0 AS EXCHANGE_RATE    --환율
        , 0 AS GL_CURRENCY_AMOUNT   --외화금액
        
        , NULL AS MANAGEMENT1 --관리항목1
        , NULL AS MANAGEMENT2 --관리항목2
        , NULL AS REFER1  --관리항목3
        , NULL AS REFER2  --관리항목4
        , NULL AS REFER3  --관리항목5
        , NULL AS REFER4  --관리항목6
        , NULL AS REFER5  --관리항목7
        , NULL AS REFER6  --관리항목8
        , NULL AS REFER7  --관리항목9
        , NULL AS REFER8  --관리항목10
        , NULL AS REFER9  --관리항목11
        , NULL AS REFER10 --관리항목12
        , NULL AS REFER11 --관리항목13
        , NULL AS REFER12 --관리항목14
        , NULL AS REFER13 --관리항목15    
        
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --적요
        , V_SYSDATE AS CREATION_DATE	--생성일
        , t_PERSON_ID AS CREATED_BY	--생성자
        , V_SYSDATE AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID AS LAST_UPDATED_BY	--수정자 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '140'   --140(차기이월시 대표계정)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110100'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
           , B.ACCOUNT_DR_CR
    ;   
   EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '4.' || SQLERRM;
            RETURN;
  END;

    --2-3-2.이 문장으로 위의 값을 수정한다.
  BEGIN
    FOR UPD_AMT_MST IN (
        --계정타입이 [차기이월시 대표계정]인 계정을 추출한다.
        SELECT DISTINCT    -- 전호수 추가(2013-02-18) : 동일한 계정에 대해 중복 발생)--
               A.ACCOUNT_CODE, A.ACCOUNT_DR_CR
        FROM FI_ACCOUNT_CONTROL A, FI_FORWARD_AMT B
        WHERE A.SOB_ID = W_SOB_ID 
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CLASS_ID IN
                (
                    SELECT COMMON_ID
                    FROM FI_COMMON 
                    WHERE SOB_ID = W_SOB_ID 
                        AND ORG_ID = W_ORG_ID 
                        AND GROUP_CODE = 'ACCOUNT_CLASS'
                        AND CODE = '140'   --140(차기이월시 대표계정)
                )
            AND A.ACCOUNT_CODE = B.ACCOUNT_CODE    
    ) LOOP
    
        FOR UPD_AMT_DET IN (
            SELECT
                  A.ACCOUNT_CODE
                , (B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR      
                , CASE (B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
                    WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
                    WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
                  END REMAIN_AMT    --잔액
            FROM FI_SLIP_LINE A ,
                (
                    SELECT * 
                    FROM FI_ACCOUNT_CONTROL 
                    WHERE SOB_ID = W_SOB_ID 
                        AND ORG_ID = W_ORG_ID
                        
                        --계정타입은 [차기이월시 귀속계정]이면서
                        AND ACCOUNT_CLASS_ID IN
                            (
                                SELECT COMMON_ID
                                FROM FI_COMMON 
                                WHERE SOB_ID = W_SOB_ID 
                                    AND ORG_ID = W_ORG_ID 
                                    AND GROUP_CODE = 'ACCOUNT_CLASS'
                                    AND CODE = '150'   --150(차기이월시 귀속계정)
                            )
                        
                        --상위계정은 [차기이월시 대표계정]인 경우
                        AND UP_ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE

                ) B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
                --AND A.ACCOUNT_CODE = '1110100'
                AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
            GROUP BY A.ACCOUNT_CODE 
                   , B.ACCOUNT_DR_CR
        ) LOOP
        
            IF UPD_AMT_MST.ACCOUNT_DR_CR = '1' THEN --[차기이월시 대표계정]의 계정이 '차변' 계정이면
            
                IF UPD_AMT_DET.ACCOUNT_DR_CR = '1' THEN --[차기이월시 귀속계정]의 계정이 '차변' 계정이면
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT + UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;
                    
                ELSE    --[차기이월시 귀속계정]의 계정이 '대변' 계정이면
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT - UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;                
                
                END IF;
            
            ELSE    --[차기이월시 대표계정]의 계정이 '대변' 계정이면
            
                IF UPD_AMT_DET.ACCOUNT_DR_CR = '1' THEN --[차기이월시 귀속계정]의 계정이 '차변' 계정이면
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT - UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;
                    
                ELSE    --[차기이월시 귀속계정]의 계정이 '대변' 계정이면
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT + UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;                
                
                END IF;            
            
            END IF;
        
        END LOOP UPD_AMT_DET;

    
    END LOOP UPD_AMT_MST;
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '5.' ||  SQLERRM;
            RETURN;
  END;


--2-4. 180 : 차기이월시 거래처로만
--이 계정타입을 둔 대표적 이유는 [받을어음]계정 때문이다.
--위 계정은 일반적인 경우처럼 관리항목별로 이월자료를 추출하면 이 계정의 속성[차변계정임.]에 따른 필수관리항목의 일부 자료가 없어
--INSERT하려는 FI_SLIP_LINE 테이블에 자료를 INSERT 할 수 없는 경우 등이 발생한다.
--참조>현 구조상 위처럼 처리한 것이지, 사실은 위처럼 하는것은 좋지는 않다. 그 이유는 차기이월은 단순히 금액을 이월하는 것이므로
--위 처럼 각 계정의 필수 관리항목 등을 점검할 필요가 없다. 그런데 지금 전표쪽에 TRIGGER가 걸려있어 무조건 CHECK를 하기 때문에
--불가분하게 [180 : 차기이월시 거래처로만] 이러한 계정타입을 만들게 된 것이다.

  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --차기이월년도
        , W_SOB_ID AS SOB_ID    --회사아이디
        , W_ORG_ID AS ORG_ID    --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --회계일자
        , t_DEPT_ID --발의부서
        , t_PERSON_ID AS PERSON_ID  --발의자
        , 'BLS' AS SLIP_TYPE    --전표유형(기초잔액)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --계정통제아이디
        , A.ACCOUNT_CODE    --계정코드
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --차대구분(0-차, 1-대)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --차변이면
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --대변이면
          END REMAIN_AMT    --이월금액
          
        , 'KRW' AS CURRENCY_CODE --통화
        , 0 AS EXCHANGE_RATE    --환율
        , 0 AS GL_CURRENCY_AMOUNT   --외화금액
        
        , A.MANAGEMENT1 --관리항목1
        , MIN(A.MANAGEMENT2) --관리항목2
        , MIN(A.REFER1)  --관리항목3
        , MIN(A.REFER2)  --관리항목4
        , MIN(A.REFER3)  --관리항목5
        , MIN(A.REFER4)  --관리항목6
        , MIN(A.REFER5)  --관리항목7
        , MIN(A.REFER6)  --관리항목8
        , MIN(A.REFER7)  --관리항목9
        , MIN(A.REFER8)  --관리항목10
        , MIN(A.REFER9)  --관리항목11
        , MIN(A.REFER10) --관리항목12
        , MIN(A.REFER11) --관리항목13
        , MIN(A.REFER12) --관리항목14
        , MIN(A.REFER13) --관리항목15         
        
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --적요
        , V_SYSDATE AS CREATION_DATE	--생성일
        , t_PERSON_ID AS CREATED_BY	--생성자
        , V_SYSDATE AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID AS LAST_UPDATED_BY	--수정자 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '180'   --180(차기이월시 거래처로만)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110700'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE, A.MANAGEMENT1
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : 이월기초자료 생성작업 중 오류가 발생했습니다.
            O_MESSAGE := '6.' ||  SQLERRM;
            RETURN;
  END;







--3.추출된 이월금액이 '0'인 자료를 삭제한다.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND GL_AMOUNT = 0
    ;    


--4.추출된 자료 중 이월금액은 있으나, 합산을 했을 경우 잔액이 '0'인 자료를 삭제한다.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND ACCOUNT_CODE IN (
            SELECT ACCOUNT_CODE
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR
            GROUP BY ACCOUNT_CODE
            HAVING SUM(GL_AMOUNT)  = 0
            )
    ; 








--5.미처분이익잉여금에 당기순이익 금액을 가산해준다.
--이 부분의 논리는 재무상태표의 논리와 동일하다.

    --5-1.미처분이익잉여금 계정 값을 보정한다.
    --이렇게 임의로 값을 보정하는 이유는 당기순이익은 미처분이익잉여금 계정으로 전표 등록을 하지 않기 때문이다.
    --같은 사유로 당기이월(매년 말에 하는 이월작업을 말한다.) 시에도 미처분이익잉여금 계정은 값을 추출해서 이월해야 한다.

    --손익계산서 테이블에서 당기의 당기순이익 자료를 가져온다. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID          --회사아이디
        , W_ORG_ID          --사업부아이디
        , 2472              --보고서기준세트아이디
        , W_FORWARD_YEAR    --결산년
        , 'M'               --자료구분(M : 월, Q : 분기, H : 반기, Y : 년)
        , 'M01'             --조회 시작월(예> M01 : 1월인경우)
        , 'M12'             --조회 종료월(예> M12 : 12월인경우)  
    );
    
    BEGIN   
      SELECT LAST_LEVEL_AMT_SUM
      INTO t_THIS_NON_LAST_AMT
      FROM FI_FS_IS_PARADE
      WHERE ITEM_CODE = '15';
    EXCEPTION WHEN OTHERS THEN
      t_THIS_NON_LAST_AMT := 0;
    END;

    --미처분이익잉여금(계정 : 3500100) 값을 수정한다.    
    MERGE INTO FI_FORWARD_AMT FA
    USING( SELECT A.ACCOUNT_CONTROL_ID
                , A.ACCOUNT_CODE     
                , A.ACCOUNT_DESC
                , A.ACCOUNT_DR_CR           
                , A.SOB_ID
                , A.ORG_ID
                , NVL(t_THIS_NON_LAST_AMT, 0) AS t_THIS_NON_LAST_AMT
             FROM FI_ACCOUNT_CONTROL A
            WHERE A.ACCOUNT_CODE     = '3500100'
              AND A.SOB_ID           = W_SOB_ID
              AND A.ORG_ID           = W_ORG_ID
          ) SX1
    ON ( FA.ACCOUNT_CONTROL_ID       = SX1.ACCOUNT_CONTROL_ID
      AND FA.SOB_ID                  = SX1.SOB_ID
      AND FA.ORG_ID                  = SX1.ORG_ID 
       )
    WHEN MATCHED THEN
      UPDATE 
      SET FA.GL_AMOUNT = NVL(FA.GL_AMOUNT, 0) + NVL(t_THIS_NON_LAST_AMT, 0)
      
    WHEN NOT MATCHED THEN
      INSERT  
      (   FORWARD_YEAR	        --차기이월년도
        , SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        --, SLIP_HEADER_ID	    --전표헤더아이디
        , GL_DATE	            --회계일자
        --, GL_NUM	            --회계번호
        , DEPT_ID	            --발의부서
        , PERSON_ID	            --발의자
        , SLIP_TYPE	            --전표유형
        , ACCOUNT_CONTROL_ID    --계정통제아이디
        , ACCOUNT_CODE	        --계정코드
        , ACCOUNT_DR_CR	        --차대구분(0-차, 1-대)
        , GL_AMOUNT	            --이월금액
        , CURRENCY_CODE	        --통화
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT	--외화금액
        , MANAGEMENT1	        --관리항목1
        , MANAGEMENT2	        --관리항목2
        , REFER1	            --관리항목3
        , REFER2	            --관리항목4
        , REFER3	            --관리항목5
        , REFER4	            --관리항목6
        , REFER5	            --관리항목7
        , REFER6	            --관리항목8
        , REFER7	            --관리항목9
        , REFER8	            --관리항목10
        , REFER9	            --관리항목11
        , REFER10	            --관리항목12
        , REFER11	            --관리항목13
        , REFER12	            --관리항목14
        , REFER13	            --관리항목15
        , REMARK	            --적요
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자    
    ) VALUES
    (
          W_FORWARD_YEAR   --차기이월년도
        , W_SOB_ID         --회사아이디
        , W_ORG_ID         --사업부아이디
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101')  --회계일자
        , t_DEPT_ID                              --발의부서
        , t_PERSON_ID                            	--발의자
        , 'BLS'                                   --전표유형(기초잔액)
        , SX1.ACCOUNT_CONTROL_ID                  --계정통제아이디
        , SX1.ACCOUNT_CODE                        --계정코드
        , SX1.ACCOUNT_DR_CR                       --차대구분(0-차, 1-대)
        
        , CASE SX1.ACCOUNT_DR_CR                  --계정의 차대구분 속성이
            WHEN '1' THEN NVL(t_THIS_NON_LAST_AMT, 0) --차변이면
            WHEN '2' THEN NVL(t_THIS_NON_LAST_AMT, 0) --대변이면
          END                                      --이월금액
          
        , 'KRW'                                    --통화
        , 0                                        --환율
        , 0                                        --외화금액
        , NULL                                     --관리항목1
        , NULL                                     --관리항목2
        , NULL                                     --관리항목3
        , NULL                                     --관리항목4
        , NULL --AS REFER3  --관리항목5
        , NULL --AS REFER4  --관리항목6
        , NULL --AS REFER5  --관리항목7
        , NULL --AS REFER6  --관리항목8
        , NULL --AS REFER7  --관리항목9
        , NULL --AS REFER8  --관리항목10
        , NULL --AS REFER9  --관리항목11
        , NULL --AS REFER10 --관리항목12
        , NULL --AS REFER11 --관리항목13
        , NULL --AS REFER12 --관리항목14
        , NULL --AS REFER13 --관리항목15
        , W_FORWARD_YEAR || '년도 기말잔액 차기이월 [' || SX1.ACCOUNT_CODE || '-' || SX1.ACCOUNT_DESC || ' ]' --AS REMARK  --적요
        , V_SYSDATE --AS CREATION_DATE	--생성일
        , t_PERSON_ID --AS CREATED_BY	--생성자
        , V_SYSDATE --AS LAST_UPDATE_DATE	--수정일
        , t_PERSON_ID --AS LAST_UPDATED_BY	--수정자 
     )   
    ;
    


    --5-2.미처분이익잉여금(계정 : 3500100) 계정과목을 이월이익잉여금(계정 : 3500300) 계정과목으로 변경해준다.
    --참조>이월된 이월이익잉여금 계정은 미처분이익잉여금 계정으로의 대체전표 입력을 통해 대체된다.
    
    --차기이월을 위해 추출한 자료 중 이월이익잉여금(계정 : 3500300)의 자료가 있으면 해당 계정의 금액을 수정하고
    --없으면 미처분이익잉여금(계정 : 3500100) 계정과목을 이월이익잉여금(계정 : 3500300) 계정과목으로 변경해준다.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND ACCOUNT_CODE = '3500300' ;    
    
    IF t_CNT > 0 THEN
        UPDATE FI_FORWARD_AMT
        SET GL_AMOUNT = NVL(GL_AMOUNT, 0) + 
                NVL((SELECT SUM(GL_AMOUNT)
                        FROM FI_FORWARD_AMT
                        WHERE SOB_ID = W_SOB_ID
                            AND ORG_ID = W_ORG_ID
                            AND FORWARD_YEAR = W_FORWARD_YEAR
                            AND ACCOUNT_CODE = '3500100'
                    ), 0)
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500300' ; 
        
        --미처분이익잉여금(계정 : 3500100) 계정 자료를 지운다.
        DELETE FI_FORWARD_AMT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500100' ;            
    ELSE
        UPDATE FI_FORWARD_AMT
        SET ACCOUNT_CODE = '3500300'
            , ACCOUNT_CONTROL_ID = 
                    (
                        SELECT ACCOUNT_CONTROL_ID
                        FROM FI_ACCOUNT_CONTROL
                        WHERE SOB_ID = W_SOB_ID
                            AND ORG_ID = W_ORG_ID
                            AND ACCOUNT_SET_ID = 10
                            AND ACCOUNT_CODE = '3500300'                    
                    )
            , REMARK = W_FORWARD_YEAR || '년도 기말잔액 차기이월 [3500300-이월이익잉여금 ]'   --적요
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500100' ;  

    END IF;
    
    





--6.관리헝목명 UPDATE   
--이 부분은 없어도 차기이월을 함에는 문제가 없다.
--그럼에도 이 부분을 처리해주는 이유는 프로그램에서 자료 확인 시 좀 더 편리하게 보기 위해서이다.

    t_ACCOUNT_CONTROL_ID := NULL;
    
    FOR REC_MANAGEMENT_NM IN (
        SELECT ACCOUNT_CONTROL_ID
        FROM FI_FORWARD_AMT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
        ORDER BY ACCOUNT_CODE
    ) LOOP
        
        
        --DBMS_OUTPUT.PUT_LINE(REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID);
        
        
        --앞전에 이미 처리된 계정이라면 SKIP한다.
        IF t_ACCOUNT_CONTROL_ID = REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID THEN
        
            NULL;
            
        ELSE
        
            t_ACCOUNT_CONTROL_ID := REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID;
                
            SELECT 
                  REFER1_ID	    --관리항목아이디1
                , REFER2_ID	    --관리항목아이디2
                , REFER3_ID	    --관리항목아이디3
                , REFER4_ID	    --관리항목아이디4
                , REFER5_ID	    --관리항목아이디5
                , REFER6_ID	    --관리항목아이디6
                , REFER7_ID	    --관리항목아이디7
                , REFER8_ID	    --관리항목아이디8
                , REFER9_ID	    --관리항목아이디9
                , REFER10_ID	--관리항목아이디10
                , REFER11_ID	--관리항목아이디11
                , REFER12_ID	--관리항목아이디12
                , REFER13_ID	--관리항목아이디13
                , REFER14_ID	--관리항목아이디14
                , REFER15_ID	--관리항목아이디15
            INTO
                  t_REFER1_ID	--관리항목아이디1
                , t_REFER2_ID	--관리항목아이디2
                , t_REFER3_ID	--관리항목아이디3
                , t_REFER4_ID	--관리항목아이디4
                , t_REFER5_ID	--관리항목아이디5
                , t_REFER6_ID	--관리항목아이디6
                , t_REFER7_ID	--관리항목아이디7
                , t_REFER8_ID	--관리항목아이디8
                , t_REFER9_ID   --관리항목아이디9
                , t_REFER10_ID	--관리항목아이디10
                , t_REFER11_ID	--관리항목아이디11
                , t_REFER12_ID	--관리항목아이디12
                , t_REFER13_ID	--관리항목아이디13
                , t_REFER14_ID	--관리항목아이디14
                , t_REFER15_ID	--관리항목아이디15         
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND ACCOUNT_SET_ID = 10
                AND ACCOUNT_CONTROL_ID = t_ACCOUNT_CONTROL_ID
            ;
                           
            --관리항목 1~15번 까지 아래와 동일한 취지의 IF문이 15번 반복된다.
            --관리항목1번
            IF t_REFER1_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER1_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'MANAGEMENT1', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;
            END IF;


            --관리항목2번
            IF t_REFER2_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER2_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'MANAGEMENT2', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목3번
            IF t_REFER3_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER3_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER1', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;            
            
            --관리항목4번
            IF t_REFER4_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER4_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER2', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목5번
            IF t_REFER5_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER5_ID);               
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER3', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --관리항목6번
            IF t_REFER6_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER6_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER4', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목7번
            IF t_REFER7_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER7_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER5', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목8번
            IF t_REFER8_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER8_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER6', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목9번
            IF t_REFER9_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER9_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER7', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --관리항목10번
            IF t_REFER10_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER10_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER8', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목11번
            IF t_REFER11_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER11_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER9', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --관리항목12번
            IF t_REFER12_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER12_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER10', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --관리항목13번
            IF t_REFER13_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER13_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER11', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --관리항목14번
            IF t_REFER14_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER14_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER12', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;            
            
            --관리항목15번
            IF t_REFER15_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER15_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER13', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
   
        END IF;   
      
    END LOOP REC_MANAGEMENT_NM;



    --FCM_10432 : 이월기초자료 생성작업이 정상적으로 완료되었습니다.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10432', NULL);   

END CREATE_FORWARD_AMT;







--관리항목명을 수정할 수 있는 관리항목인지 여부를 파악하여 해당하는 항목명 구분문자를 넘긴다.
--이 PROCEDURE는 [관리항목별원장조회 : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] 프로그램의 것을 차용한 것이다.
--CREATE_FORWARD_AMT PROCEDURE에서 내부적으로 사용한다.
FUNCTION MANAGEMENT_UPD_YN_F( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_COMMON_ID       IN FI_COMMON.COMMON_ID%TYPE         --공통코드 ID
) RETURN VARCHAR2

AS

t_DATA VARCHAR2(100) := 'NONE';

BEGIN
    
    SELECT VALUE3
    INTO t_DATA
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GROUP_CODE = 'MANAGEMENT_CODE'
        AND ENABLED_FLAG = 'Y'
        AND VALUE3 IN 
                (
                      'BANK'            --금융기관(23)                [TABLE : FI_BANK]
                    , 'CUSTOMER'        --거래처(01)                  [TABLE : FI_SUPP_CUST_V]
                    , 'BANK_ACCOUNT'    --계좌번호(03)                [TABLE : FI_BANK_ACCOUNT]
                    , 'CREDIT_CARD'     --결제카드, 카드번호(02, 26)  [TABLE : FI_CREDIT_CARD]
                    , 'PERSON_NUM'      --사원(11)                    [TABLE : HRM_PERSON_MASTER]
                    , 'DEPT'            --부서(08)                    [TABLE : FI_DEPT_MASTER]
                    , 'COSTCENTER'      --원가코드(27)                [TABLE : CST_COST_CENTER]           


                    --참조>어음처리구분
                    --현재는 전표 입력 시 작업자가 임의로 값을 입력하도록 되어 있는데 이는 POPUP을 이용해서 입력하도록 변경되는게 
                    --옳은 방법이다. 내가 관여할바가 아닌 것 같아서 놔둔다.
                    , 'BILL_STATUS'             --어음처리구분(07)               [TABLE : FI_COMMON]
                    
                    , 'TAX_CODE'                --사업장(10)                     [TABLE : FI_COMMON]
                    , 'VAT_REASON'              --부가세대급금_사유구분(12)      [TABLE : FI_COMMON]
                    , 'VAT_TYPE_AP'             --부가세대급금_세무유형(13)      [TABLE : FI_COMMON]
                    , 'VAT_TYPE_AR'             --부가세예수금_세무유형(33)      [TABLE : FI_COMMON]
                    , 'SCHEDULE_REPORT_OMIT'    --예정신고누락분여부(36)         [TABLE : FI_COMMON]
                    , 'MODIFY_TAX_REASON'       --수정전자세금계산서사유구분(37) [TABLE : FI_COMMON]
                    , 'OTHER_ACCOUNT_GB'        --타계정구분(38)                 [TABLE : FI_COMMON]            
                )
        AND COMMON_ID = W_COMMON_ID
    ;    
    
                
    RETURN t_DATA;
    
    
    --아래 문장이 반드시 필요하다. SELECT 문장의 결과 자료가 없을 경우의 처리이다.
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN 'NONE';

END MANAGEMENT_UPD_YN_F;









--관리항목명 수정
--이 PROCEDURE는 [관리항목별원장조회 : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] 프로그램의 것을 차용한 것이다.
--CREATE_FORWARD_AMT PROCEDURE에서 내부적으로 사용한다.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    
    --계정통제아이디; 계정코드를 사용하는 것과 동일한 것인데 편의상 아이디를 이용했을 뿐이다.
    , W_ACCOUNT_CONTROL_ID  IN FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE --계정통제아이디
    
    , W_COLUMN              IN  VARCHAR2    --수정할 칼럼명
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
)

AS

BEGIN
   

--연관 프로시져 : FI_ACCOUNT_CONTROL_G > LU_CONTROL_ITEM / LU_MANAGEMENT_ITEM
--위 2 프로시져는 동일한 내용인데, 파리미터만 다를뿐이다.

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --금융기관(23)   [TABLE : FI_BANK]
      
        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --거래처(01)   [TABLE : FI_SUPP_CUST_V]
        
        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        
    
    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --계좌번호(03)  [TABLE : FI_BANK_ACCOUNT]
    
        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;
       
    ELSIF W_MANAGEMENT_GUBUN = 'PAYABLE_BILL' THEN      --지급어음번호(35)    [TABLE : FI_PAYABLE_BILL]

        NULL;   --자료도 없고, 무언가 부정확하여 처리안한다.
    
    ELSIF W_MANAGEMENT_GUBUN = 'RECEIVABLE_BILL' THEN   --받을어음번호(21)    [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    
        NULL;   --POPUP으로 처리하는 걸로 되어있지만 실상은 전표등록 시 직접 KEY-IN한다.
    
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --결제카드, 카드번호(02, 26)  [TABLE : FI_CREDIT_CARD]
        
        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --사원(11)    [TABLE : HRM_PERSON_MASTER]        
        
        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.MANAGEMENT1
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.MANAGEMENT2
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER1
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER2
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER3
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER4
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER5
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER6
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER7
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER8
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER9
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER10
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER11
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER12
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER13
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;         
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --부서(08)    [TABLE : FI_DEPT_MASTER]        

        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;                

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --원가코드(27)  [TABLE : CST_COST_CENTER]                

        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;           

    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C번호(32) [TABLE : FI_LC_MASTER]
    
        NULL;   --L/C번호 자체로 의미있는 자료지 더 이상의 설명이 필요없다 판단했다.
    
    ELSE
        /*
            --참조>어음처리구분
            --현재는 전표 입력 시 작업자가 임의로 값을 입력하도록 되어 있는데 이는 POPUP을 이용해서 입력하도록 변경되는게 
            --옳은 방법이다. 내가 관여할바가 아닌 것 같아서 놔둔다.
            , 'BILL_STATUS'             --어음처리구분(07)               [TABLE : FI_COMMON]
            
            , 'TAX_CODE'                --사업장(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --부가세대급금_사유구분(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --부가세대급금_세무유형(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --부가세예수금_세무유형(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --예정신고누락분여부(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --수정전자세금계산서사유구분(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --타계정구분(38)                 [TABLE : FI_COMMON]
        */               

        --아래 IF문은 거의 동일하다. 단지, SET 다음의 변경될 COLUMN명과 IN-LINE VIEW안의 COLUMN만 바뀔뿐이다.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;           
        
           
    END IF;
    
END UPD_MANAGEMENT_NM;








--차기이월금액 조회(계정별)
PROCEDURE LIST_FORWARD_AMT_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
)

AS

BEGIN

    OPEN P_CURSOR FOR

    --본 쿼리에 있는 MIN등의 집계합수는 별다른 의미는 없고, GROUP BY절에 별도로 기술하지 않은 COLUMN들을 보기 위함일 뿐이다.
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR  --차기이월년도
        , MIN(GL_DATE) AS GL_DATE   --이월일자
        , ACCOUNT_CODE  --계정코드
        , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F2(MIN(A.SOB_ID), MIN(A.ORG_ID), 10, A.ACCOUNT_CODE) AS ACCOUNT_NM  --계정명
        , DECODE(MIN(ACCOUNT_DR_CR), '1', '차변', '2', '대변') AS ACCOUNT_DR_CR    --계정성격
        , SUM(GL_AMOUNT) AS GL_AMOUNT    --이월금액
        , MIN(SLIP_TYPE) AS SLIP_TYPE --전표유형
        , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', MIN(SLIP_TYPE), MIN(SOB_ID), MIN(ORG_ID)) AS SLIP_TYPE_NM    --유형
        , MIN(DEPT_ID) AS DEPT_ID   --발의부서
        , FI_DEPT_MASTER_G.DEPT_NAME_F(MIN(DEPT_ID)) AS DEPT_NAME   --이월처리부서(97 : 재무관리파트)
        , MIN(PERSON_ID) AS PERSON_ID --발의자
        , HRM_PERSON_MASTER_G.NAME_F(MIN(PERSON_ID)) AS PERSON_NAME   --이월처리자(269 : 서인철)
        , MIN(CREATION_DATE) AS CREATION_DATE   --이월처리일
    FROM FI_FORWARD_AMT A
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
    GROUP BY FORWARD_YEAR, ACCOUNT_CODE
    ORDER BY ACCOUNT_CODE
    ;

END LIST_FORWARD_AMT_MST;









--차기이월금액 조회(상세항목별)
PROCEDURE LIST_FORWARD_AMT_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
)

AS

BEGIN

    --본 쿼리의 일부 칼럼을 주석으로 처리한 이유는 
    --현재의 FRAMEWORK이 원활치 못하여 이 칼럼들을 주석처리하지 않으면 ERROR가 떠서이다. 이해가 안되지만 그냥 넘어간다.

    OPEN P_CURSOR FOR

    SELECT
          FORWARD_YEAR	--차기이월년도
        , TO_CHAR(GL_DATE, 'YYYY-MM-DD') AS GL_DATE	    --회계일자
        , ACCOUNT_CODE	--계정코드
        , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F2(SOB_ID, ORG_ID, 10, ACCOUNT_CODE) AS ACCOUNT_NM  --계정명
        , ACCOUNT_DR_CR	--차대구분(0-차, 1-대)
        , DECODE(ACCOUNT_DR_CR, '1', '차변', '2', '대변') AS ACCOUNT_DR_CR_NM    --계정성격       
        , SUM(GL_AMOUNT) AS GL_AMOUNT	--이월금액       
        , CURRENCY_CODE	    --통화            
        , MANAGEMENT1	    --관리항목1
        , MANAGEMENT1_NM	--관리항목명1       
        , MANAGEMENT2	    --관리항목2
        , MANAGEMENT2_NM    --관리항목명2
        , REFER1	        --관리항목3
        , REFER1_NM	        --관리항목명3
        , REFER2	        --관리항목4
        , REFER2_NM	        --관리항목명4
        , REFER3	        --관리항목5
        , REFER3_NM	        --관리항목명5
        
        , REMARK	--적요
        , SLIP_TYPE         --전표유형
        , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SLIP_TYPE, SOB_ID, ORG_ID) AS SLIP_TYPE_NM    --유형
        , TO_CHAR(CREATION_DATE, 'YYYY-MM-DD') AS CREATION_DATE     --이월처리일         
        --, DEPT_ID   --발의부서      
        , FI_DEPT_MASTER_G.DEPT_NAME_F(DEPT_ID) AS DEPT_NAME   --이월처리부서(97 : 재무관리파트)
        --, PERSON_ID --발의자
        , HRM_PERSON_MASTER_G.NAME_F(PERSON_ID) AS PERSON_NAME   --이월처리자(269 : 서인철)
  

        --, SOB_ID	            --회사아이디
        --, ORG_ID	            --사업부아이디
        --, ACCOUNT_CONTROL_ID	--계정통제아이디    
        , SLIP_HEADER_ID	    --전표헤더아이디    
        , GL_NUM	            --회계번호
        , EXCHANGE_RATE	        --환율
        , GL_CURRENCY_AMOUNT    --외화금액
        , REFER4	    --관리항목6
        , REFER4_NM	    --관리항목명6
        , REFER5	    --관리항목7
        , REFER5_NM	    --관리항목명7
        , REFER6	    --관리항목8
        , REFER6_NM	    --관리항목명8
        , REFER7	    --관리항목9
        , REFER7_NM	    --관리항목명9
        , REFER8	    --관리항목10
        , REFER8_NM	    --관리항목명10
        , REFER9	    --관리항목11
        , REFER9_NM	    --관리항목명11
        , REFER10	    --관리항목12
        , REFER10_NM	--관리항목명12
        , REFER11	    --관리항목13
        , REFER11_NM	--관리항목명13
        , REFER12	    --관리항목14
        , REFER12_NM	--관리항목명14
        , REFER13	    --관리항목15
        , REFER13_NM    --관리항목명15       
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR               
    GROUP BY ROLLUP(ACCOUNT_CODE, (FORWARD_YEAR, GL_DATE, ACCOUNT_CONTROL_ID, ACCOUNT_DR_CR, CURRENCY_CODE, SLIP_TYPE 
                                   , CREATION_DATE, MANAGEMENT1, MANAGEMENT1_NM
                                   , MANAGEMENT2, MANAGEMENT2_NM, REFER1, REFER1_NM
                                   , REFER2, REFER2_NM, REFER3, REFER3_NM
                                   , REMARK
                                   , DEPT_ID, PERSON_ID, SOB_ID, ORG_ID, SLIP_HEADER_ID, GL_NUM, EXCHANGE_RATE
                                   , GL_CURRENCY_AMOUNT, REFER4, REFER4_NM, REFER5, REFER5_NM, REFER6, REFER6_NM
                                   , REFER7, REFER7_NM, REFER8, REFER8_NM, REFER9, REFER9_NM, REFER10, REFER10_NM
                                   , REFER11, REFER11_NM, REFER12, REFER12_NM, REFER13, REFER13_NM)
                    )
    ;              

END LIST_FORWARD_AMT_DET;










--차기이월실행
--전표 테이블에 차기이월금액을 INSERT하는 것이다.
--전표유형 : BLS(기초잔액)

--참조>전표테이블에 자료 INSERT하는 것에 대한 주석
--하기의 일반적인 전표생성 방법은 감가상각전표생성하는 것 등을 생각하면 된다.
--일반적인 전표생성 방법과 본 차기이월자료를 전표테이블에 INSERT 하는 방법에는 약간의 논리적 차이가 있다.
--일반적인 전표 생성시에는 정합성 체크를 위해 FI_SLIP_G.INSERT_SLIP_HEADER 또는 FI_SLIP_G.INSERT_SLIP_LINE의 PROCEDURE를
--호출하지만, 차기이월자료 생성시에는 전표가 아니기에 전표관련 2 테이블에 해당 자료를 직접 INSERT한다.
PROCEDURE CREATE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.    
)

AS

t_CNT NUMBER  := 0;
t_SLIP_CNT NUMBER  := 0;

t_SLIP_HEADER_ID    FI_FORWARD_AMT.SLIP_HEADER_ID%TYPE;     --전표헤더아이디
t_GL_NUM            FI_FORWARD_AMT.GL_NUM%TYPE;             --전표번호
t_GL_DATE           FI_FORWARD_AMT.GL_DATE%TYPE;            --회계일자
t_PERSON_ID         FI_FORWARD_AMT.PERSON_ID%TYPE;          --발의자
t_PERIOD_NAME       FI_SLIP_HEADER.PERIOD_NAME%TYPE;        --회계년월
t_ACCOUNT_BOOK_ID   FI_SLIP_HEADER.ACCOUNT_BOOK_ID%TYPE;    --회계장부아이디

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);       --수정일자

BEGIN

    --차기이월 실행을 위한 기초자료가 생성되어 있는지의 유무를 파악한다.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR   ;
        
        
    --차기이월자료가 이미 생성되어 있는지를 파악한다.
    --차기이월할 자료에 전표번호가 있다는 것은 본 프로시져를 실행한 결과 차기이월자료가 이미 생성되었다는 뜻이다.
    SELECT COUNT(*)
    INTO t_SLIP_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND GL_NUM IS NOT NULL  ;


        
    IF t_CNT = 0 THEN
        --FCM_10424 : 차기이월을 위한 기초자료를 생성 후 실행하세요.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10424', NULL);  
    ELSIF t_SLIP_CNT > 0 THEN
        --FCM_10430 : 기 생성한 차기이월자료를 삭제 후 작업바랍니다.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL);      
    ELSE
    
        BEGIN 

            --1.기초자료 생성
            
            /*
            전표생성하는 것이라면 아래의 체크를 실행해서 해당 회계기간이 열려있지 않으면 에러를 발생시키는 게 맞지만 
            이월자료는 전표테이블에 자료를 INSERT하는 건 맞지만 전표가 아니기에 이런 체크를 하면 안된다.
            
            IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
                RAISE ERRNUMS.Data_Not_Opened;
            END IF;        
            */
                        
            
            --전표헤더아이디를 구한다.
            SELECT FI_SLIP_HEADER_S1.NEXTVAL
            INTO t_SLIP_HEADER_ID
            FROM DUAL;                       
               
           
            t_PERIOD_NAME := W_FORWARD_YEAR + 1 || '-01';   --회계년월
            t_ACCOUNT_BOOK_ID := FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID);  --회계장부아이디


            SELECT GL_DATE, PERSON_ID
            INTO t_GL_DATE, t_PERSON_ID
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ROWNUM = 1  ;             
            
            t_GL_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('BL', W_SOB_ID, t_GL_DATE, t_PERSON_ID); --(채번된)전표번호
            


            --2.FI_FORWARD_AMT 테이블 자료(SLIP_HEADER_ID, GL_NUM) UPDATE
            UPDATE FI_FORWARD_AMT
            SET SLIP_HEADER_ID = t_SLIP_HEADER_ID
                , GL_NUM = t_GL_NUM
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   ;            



            --3.FI_SLIP_HEADER 테이블에 자료 INSERT
                           
            INSERT INTO FI_SLIP_HEADER( 
                  SLIP_HEADER_ID        --전표헤더아이디
                , SLIP_DATE             --기표일자
                , SLIP_NUM              --기표번호
                , SOB_ID                --회사아이디
                , ORG_ID                --사업부아이디
                , DEPT_ID               --발의부서
                , PERSON_ID             --발의자
                , BUDGET_DEPT_ID        --예산부서
                , ACCOUNT_BOOK_ID       --회계장부아이디
                , SLIP_TYPE             --전표유형
                , PERIOD_NAME           --회계년월
                , CONFIRM_YN            --승인여부
                , CONFIRM_DATE          --승인일자
                , CONFIRM_PERSON_ID     --승인처리자
                , GL_DATE               --회계일자
                , GL_NUM                --회계번호
                , GL_AMOUNT             --전표금액
                , CURRENCY_CODE         --통화
                , REQ_BANK_ACCOUNT_ID   --공급사은행계좌
                , REQ_PAYABLE_TYPE      --지급요청방법
                , REQ_PAYABLE_DATE      --지급요청일
                , REMARK                --전표적요
                , CREATION_DATE         --생성일
                , CREATED_BY            --생성자
                , LAST_UPDATE_DATE      --수정일
                , LAST_UPDATED_BY       --수정자
            )
            SELECT
                  SLIP_HEADER_ID    --전표헤더아이디
                , GL_DATE           --기표일자
                , GL_NUM            --기표번호
                , SOB_ID            --회사아이디
                , ORG_ID            --사업부아이디
                , DEPT_ID           --발의부서
                , PERSON_ID         --발의자
                , NULL              --예산부서
                , t_ACCOUNT_BOOK_ID --회계장부아이디
                , SLIP_TYPE         --전표유형
                , t_PERIOD_NAME     --회계년월
                , 'Y'               --승인여부
                , GL_DATE           --승인일자
                , PERSON_ID         --승인처리자
                , GL_DATE           --회계일자
                , GL_NUM            --회계번호
                , 0                 --전표금액
                , 'KRW'             --통화                
                , NULL              --공급사은행계좌
                , NULL              --지급요청방법
                , NULL              --지급요청일
                , W_FORWARD_YEAR || '년도 기말잔액 차기이월'  --전표적요; 2011년도 기말잔액 차기이월
                , V_SYSDATE         --생성일
                , PERSON_ID         --생성자
                , V_SYSDATE         --수정일
                , PERSON_ID         --수정자
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR
                AND ROWNUM = 1  ;   
                --FI_FORWARD_AMT테이블에 있는 많은 자료 중 임의의 1줄을 추출해서 전표헤더에 INSERT하기 위함이다.
                    

            --4.FI_SLIP_LINE 테이블에 자료 INSERT           

            INSERT INTO FI_SLIP_LINE( 
                  SLIP_LINE_ID          --전표라인아이디
                , SLIP_DATE             --기표일자
                , SLIP_NUM              --기표번호
                , SLIP_LINE_SEQ         --전표라인번호
                , SLIP_HEADER_ID        --전표헤더아이디
                , SOB_ID                --회사아이디
                , ORG_ID                --사업부아이디
                , DEPT_ID               --발의부서
                , PERSON_ID             --발의자
                , ACCOUNT_BOOK_ID       --회계장부아이디
                , SLIP_TYPE             --전표유형
                , PERIOD_NAME           --회계년월
                , CONFIRM_YN            --승인여부
                , CONFIRM_DATE          --승인일자
                , CONFIRM_PERSON_ID     --승인처리자
                , GL_DATE               --회계일자
                , GL_NUM                --회계번호
                , ACCOUNT_CONTROL_ID    --계정통제아이디
                , ACCOUNT_CODE          --계정코드
                , ACCOUNT_DR_CR         --차대구분(0-차, 1-대)
                , GL_AMOUNT             --전표금액
                , CURRENCY_CODE         --통화
                , EXCHANGE_RATE         --환율
                , GL_CURRENCY_AMOUNT    --외화금액
                , MANAGEMENT1           --관리항목1
                , MANAGEMENT2           --관리항목2
                , REFER1                --관리항목3
                , REFER2                --관리항목4
                , REFER3                --관리항목5
                , REFER4                --관리항목6
                , REFER5                --관리항목7
                , REFER6                --관리항목8
                , REFER7                --관리항목9
                , REFER8                --관리항목10
                , REFER9                --관리항목11
                , REFER10               --관리항목12
                , REFER11               --관리항목13
                , REFER12               --관리항목14
                , REFER13               --관리항목15
                , REMARK                --전표적요
                , UNLIQUIDATE_SLIP_HEADER_ID    --미청산전표HEADER_ID
                , UNLIQUIDATE_SLIP_LINE_ID      --미청산전표LINE_ID
                , CREATION_DATE     --생성일
                , CREATED_BY        --생성자
                , LAST_UPDATE_DATE  --수정일
                , LAST_UPDATED_BY   --수정자
            )
            SELECT
                  FI_SLIP_LINE_S1.NEXTVAL   --전표라인아이디
                , GL_DATE               --기표일자
                , GL_NUM                --기표번호
                , ROWNUM                --전표라인번호
                , SLIP_HEADER_ID        --전표헤더아이디
                , SOB_ID                --회사아이디
                , ORG_ID                --사업부아이디
                , DEPT_ID               --발의부서
                , PERSON_ID             --발의자
                , t_ACCOUNT_BOOK_ID     --회계장부아이디
                , SLIP_TYPE             --전표유형
                , t_PERIOD_NAME         --회계년월
                , 'Y'                   --승인여부
                , GL_DATE               --승인일자
                , PERSON_ID             --승인처리자
                , GL_DATE               --회계일자
                , GL_NUM                --회계번호
                , ACCOUNT_CONTROL_ID    --계정통제아이디
                , ACCOUNT_CODE          --계정코드
                , ACCOUNT_DR_CR         --차대구분(0-차, 1-대)
                , GL_AMOUNT             --전표금액
                , CURRENCY_CODE         --통화
                , EXCHANGE_RATE         --환율
                , GL_CURRENCY_AMOUNT    --외화금액
                , MANAGEMENT1           --관리항목1
                , MANAGEMENT2           --관리항목2
                , REFER1                --관리항목3
                , REFER2                --관리항목4
                , REFER3                --관리항목5
                , REFER4                --관리항목6
                , REFER5                --관리항목7
                , REFER6                --관리항목8
                , REFER7                --관리항목9
                , REFER8                --관리항목10
                , REFER9                --관리항목11
                , REFER10               --관리항목12
                , REFER11               --관리항목13
                , REFER12               --관리항목14
                , REFER13               --관리항목15
                , REMARK                --전표적요
                , NULL                  --미청산전표HEADER_ID
                , NULL                  --미청산전표LINE_ID
                , V_SYSDATE             --생성일
                , PERSON_ID             --생성자
                , V_SYSDATE             --수정일
                , PERSON_ID             --수정자                 
            FROM
                (
                    SELECT *
                    FROM FI_FORWARD_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                    ORDER BY ACCOUNT_CODE
                )   ;    



            --FCM_10425 : 차기이월작업이 정상 수행되었습니다.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10425', NULL);
            
        
        EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
        
            --FCM_10429 : 차기이월작업 중 오류가 발생했습니다.
            --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10429', NULL);
            
            O_MESSAGE := SQLCODE || ' ;  수행결과 :  ' || SQLERRM;            
            --DBMS_OUTPUT.PUT_LINE('------ 수행결과코드값에 따른 message : ' || SQLERRM);
        END;  
        
    END IF;

END CREATE_FORWARD_SLIP;








--전표테이블(FI_SLIP_HEADER, FI_SLIP_LINE)에 등록된 차기이월자료삭제
--참조>이 삭제는 본 로직을 통해 생성된 이월자료만을 삭제한다. 
--행여 본 로직이 아닌 다른 방법(기존에 있던 기초잔액등록 프로그램)으로 추가된 이월자료는 삭제하지 않는다.
PROCEDURE DELETE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --회사아이디
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --사업부아이디
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --차기이월년도
    , W_GL_NUM          IN FI_FORWARD_AMT.GL_NUM%TYPE       --회계번호
    
    , O_MESSAGE         OUT VARCHAR2    --차기이월관련 결과 메시지를 화면으로 반환한다.
)

AS

t_CNT NUMBER  := 0;

BEGIN

    --차기이월된 자료의 존재 유무를 파악한다.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_SLIP_LINE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND SLIP_TYPE = 'BLS'   --전표유형 ; BLS(기초잔액)
        AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
        AND GL_NUM = W_GL_NUM    ;
        
     
        
    IF t_CNT = 0 THEN
        --FCM_10426 : 삭제할 차기이월된 자료가 존재하지 않습니다.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10426', NULL);        
    ELSE
        BEGIN
    
            --1.전표테이블(FI_SLIP_HEADER, FI_SLIP_LINE)에 등록된 차기이월자료를 삭제한다.
            DELETE FI_SLIP_HEADER
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE = 'BLS'   --전표유형 ; BLS(기초잔액)
                AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
                AND GL_NUM = W_GL_NUM    ; 
                
                
            DELETE FI_SLIP_LINE
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE = 'BLS'   --전표유형 ; BLS(기초잔액)
                AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
                AND GL_NUM = W_GL_NUM    ;
                
                
            --2.FI_FORWARD_AMT 테이블 자료(SLIP_HEADER_ID, GL_NUM) UPDATE
            UPDATE FI_FORWARD_AMT
            SET SLIP_HEADER_ID = NULL
                , GL_NUM = NULL
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   ;
                

            --FCM_10427 : 차기이월자료를 정상 삭제하였습니다.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10427', NULL);
            
        EXCEPTION WHEN OTHERS THEN
            --FCM_10428 : 차기이월자료 삭제 중 오류가 발생했습니다.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10428', NULL);
        END;        
        
    END IF;

END DELETE_FORWARD_SLIP;







END FI_FORWARD_AMT_G;
/
