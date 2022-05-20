CREATE OR REPLACE PACKAGE FI_CUSTOMER_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_CUSTOMER_LEDGER_G
Description  : 거래처별원장조회 Package

Reference by : calling assmbly-program id(호출 프로그램) : (거래처별원장조회)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-09   Leem Dong Ern(임동언)
*****************************************************************************/




--상단 합계내역 조회
PROCEDURE UP_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
);






--하단 상세내역 조회
PROCEDURE DET_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
);





--조회조건에서 선택한 조회할 계정목록 중 자료가 있는 계정만 보여준다.
PROCEDURE LIST_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ACCOUNT_CONTROL.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_ACCOUNT_CONTROL.ORG_ID%TYPE
    , W_ACCOUNT_SET_ID  IN  FI_ACCOUNT_CONTROL.ACCOUNT_SET_ID%TYPE
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료      
    , W_ACCOUNT_FR      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_ACCOUNT_TO      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
);





END FI_CUSTOMER_LEDGER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_CUSTOMER_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_CUSTOMER_LEDGER_G
Description  : 거래처별원장조회 Package

Reference by : calling assmbly-program id(호출 프로그램) : (거래처별원장조회)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-09   Leem Dong Ern(임동언)
*****************************************************************************/






--상단 합계내역 조회
PROCEDURE UP_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;  --차대구분(1-차변,2-대변)
t_ACCOUNT_DESC      FI_ACCOUNT_CONTROL.ACCOUNT_DESC%TYPE;   --계정명

BEGIN

    BEGIN

        SELECT
              ACCOUNT_DR_CR --차대구분(1-차변,2-대변)
            , ACCOUNT_DESC  --계정명
        INTO t_ACCOUNT_DR_CR, t_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ACCOUNT_CODE = W_ACCOUNT_CODE    ;
            
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
            
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');                    
    END;


    --특정거래처를 지정하지 않은 경우
    IF NVL(W_CUSTOMER_CD, 'NONE') = 'NONE' THEN
    
        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(CUSTOMER_CD), 1, '', W_ACCOUNT_CODE) AS ACCOUNT_CODE    --계정코드
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', t_ACCOUNT_DESC) AS ACCOUNT_DESC    --계정명
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', DECODE(t_ACCOUNT_DR_CR, '1', '차변', 2, '대변')) AS ACCOUNT_DR_CR   --차대구분
            , CUSTOMER_CD       --거래처코드
            , DECODE(GROUPING(CUSTOMER_CD), 1, '   [  총   계  ]', B.SUPP_CUST_NAME) AS SUPP_CUST_NAME   --거래처명        
            
            , B.TAX_REG_NO      --사업자등록번호
            , SUM(NVL(FORWARD_AMT, 0)) AS FORWARD_AMT    --이월금액
            , SUM(NVL(INC_AMT, 0)) AS INC_AMT            --증가
            , SUM(NVL(DEC_AMT, 0)) AS DEC_AMT            --감소
            , SUM(NVL(FORWARD_AMT, 0) + NVL(INC_AMT, 0) - NVL(DEC_AMT, 0)) AS REMAIN_AMT --잔액
        FROM
            (
                SELECT 
                      A.CUSTOMER_CD --거래처코드
                    
                    --이월금액 : 조회시작년 1월 1일 ~ 조회시작일 전일 까지의 금액 합계
                    , (
                        SELECT
                            CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                                WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --차변이면
                                WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --대변이면
                            END
                        
                        --아래 문장으로 대체한다.
                        --FROM FI_CUSTOMER_LEDGER_V
                        --WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        --    AND CUSTOMER_CD = A.CUSTOMER_CD
                        
                        --대체된 문장
                        FROM FI_SLIP_LINE
                        WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND (NVL(MANAGEMENT1, 'NONE') = A.CUSTOMER_CD OR MANAGEMENT2 = A.CUSTOMER_CD)


                            AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                        AND --이월금액 조회 종료일자는 
                                            CASE 
                                                --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                                WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                ELSE W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                            END
                            AND SLIP_TYPE = --전표유형은
                                    CASE 
                                        WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                        ELSE SLIP_TYPE   --모든 전표유형
                                    END
                    ) FORWARD_AMT --이월금액

                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN C.GL_AMOUNT --차변이면
                        WHEN '2' THEN D.GL_AMOUNT --대변이면
                    END INC_AMT --증가
                    
                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN D.GL_AMOUNT --차변이면
                        WHEN '2' THEN C.GL_AMOUNT --대변이면
                    END DEC_AMT --감소                
                FROM
                    (   --조회기간(시작일은 조회시작일의 년의 1월1일자이다.)과 조회 계정에 부합되는 거래처를 추출한다.
                        --조회시작일을 1월 1일로 하는 이유는 조회되는 자료를 재무상태표와 일치하기 위해서이다.
                        SELECT NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            
                            --이 문장만이 ELSE문 블럭의 문장과 다르다. 즉, 모든 거래처가 조회되는 경우이므로 거래처 조건이 없다.

                        GROUP BY CUSTOMER_CD
                    ) A
                    
                    --QUERY기능적참조>C, D 테이블을 1개의 테이블로 합할 수도 있는데 가독성을 배가하고,
                    --그 속도면에서도 차이가 없어 현재처럼 2개의 테이블로 했다.                
                    , ( --차변금액
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 1   --차변
                        GROUP BY CUSTOMER_CD
                        ) C
                    , ( --대변금액
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 2   --대변
                        GROUP BY CUSTOMER_CD
                        ) D       
                WHERE A.CUSTOMER_CD = C.CUSTOMER_CD(+) 
                    AND A.CUSTOMER_CD = D.CUSTOMER_CD(+) 
            ) T
            , FI_SUPP_CUST_V B
        WHERE T.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
        GROUP BY ROLLUP((CUSTOMER_CD,SUPP_CUST_NAME,TAX_REG_NO,FORWARD_AMT,INC_AMT,DEC_AMT))    
        ORDER BY ACCOUNT_CODE, CUSTOMER_CD    ;
        
    --특정거래처를 지정한 경우
    ELSE

        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(CUSTOMER_CD), 1, '', W_ACCOUNT_CODE) AS ACCOUNT_CODE    --계정코드
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', t_ACCOUNT_DESC) AS ACCOUNT_DESC    --계정명
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', DECODE(t_ACCOUNT_DR_CR, '1', '차변', 2, '대변')) AS ACCOUNT_DR_CR   --차대구분
            , CUSTOMER_CD       --거래처코드
            , DECODE(GROUPING(CUSTOMER_CD), 1, '   [  총   계  ]', B.SUPP_CUST_NAME) AS SUPP_CUST_NAME   --거래처명        
            
            , B.TAX_REG_NO      --사업자등록번호
            , SUM(NVL(FORWARD_AMT, 0)) AS FORWARD_AMT    --이월금액
            , SUM(NVL(INC_AMT, 0)) AS INC_AMT            --증가
            , SUM(NVL(DEC_AMT, 0)) AS DEC_AMT            --감소
            , SUM(NVL(FORWARD_AMT, 0) + NVL(INC_AMT, 0) - NVL(DEC_AMT, 0)) AS REMAIN_AMT --잔액
        FROM
            (
                SELECT 
                      A.CUSTOMER_CD --거래처코드
                    
                    --이월금액 : 조회시작년 1월 1일 ~ 조회시작일 전일 까지의 금액 합계
                    , (
                        SELECT
                            CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                                WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --차변이면
                                WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --대변이면
                            END
                        
                        --아래 문장으로 대체한다.
                        --FROM FI_CUSTOMER_LEDGER_V
                        --WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        --    AND CUSTOMER_CD = A.CUSTOMER_CD
                        
                        --대체된 문장
                        FROM FI_SLIP_LINE
                        WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND (MANAGEMENT1 = A.CUSTOMER_CD OR MANAGEMENT2 = A.CUSTOMER_CD)                        


                            AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                        AND --이월금액 조회 종료일자는 
                                            CASE 
                                                --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                                WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                ELSE W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                            END
                            AND SLIP_TYPE = --전표유형은
                                    CASE 
                                        WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                        ELSE SLIP_TYPE   --모든 전표유형
                                    END
                    ) FORWARD_AMT --이월금액

                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN C.GL_AMOUNT --차변이면
                        WHEN '2' THEN D.GL_AMOUNT --대변이면
                    END INC_AMT --증가
                    
                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN D.GL_AMOUNT --차변이면
                        WHEN '2' THEN C.GL_AMOUNT --대변이면
                    END DEC_AMT --감소                
                FROM
                    (   --조회기간(시작일은 조회시작일의 년의 1월1일자이다.)과 조회 계정에 부합되는 거래처를 추출한다.
                        --조회시작일을 1월 1일로 하는 이유는 조회되는 자료를 재무상태표와 일치하기 위해서이다.
                        SELECT NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            
                            AND CUSTOMER_CD = W_CUSTOMER_CD --이 문장만이 IF문 블럭의 문장과 다르다.
                        GROUP BY CUSTOMER_CD
                    ) A
                    
                    --QUERY기능적참조>C, D 테이블을 1개의 테이블로 합할 수도 있는데 가독성을 배가하고,
                    --그 속도면에서도 차이가 없어 현재처럼 2개의 테이블로 했다.                
                    , ( --차변금액
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 1   --차변
                        GROUP BY CUSTOMER_CD
                        ) C
                    , ( --대변금액
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 2   --대변
                        GROUP BY CUSTOMER_CD
                        ) D       
                WHERE A.CUSTOMER_CD = C.CUSTOMER_CD(+) 
                    AND A.CUSTOMER_CD = D.CUSTOMER_CD(+) 
            ) T
            , FI_SUPP_CUST_V B
        WHERE T.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
        GROUP BY ROLLUP((CUSTOMER_CD,SUPP_CUST_NAME,TAX_REG_NO,FORWARD_AMT,INC_AMT,DEC_AMT))    
        ORDER BY ACCOUNT_CODE, CUSTOMER_CD    ;

    END IF;


END UP_CUSTOMER_LEDGER;







--하단 상세내역 조회
PROCEDURE DET_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;      --차대구분(1-차변,2-대변)
t_ACCOUNT_DESC      FI_CUSTOMER_LEDGER.ACCOUNT_DESC%TYPE;       --계정명
t_CUSTOMER_NM       FI_CUSTOMER_LEDGER.CUSTOMER_NM%TYPE;        --거래처명
t_REMAIN_AMT        FI_CUSTOMER_LEDGER.REMAIN_AMT%TYPE := 0;    --잔액

BEGIN

    BEGIN
    
        --1.기존자료를 삭제한다.
        DELETE FI_CUSTOMER_LEDGER;    

        SELECT
              ACCOUNT_DR_CR --차대구분(1-차변,2-대변)
            , ACCOUNT_DESC  --계정명
        INTO t_ACCOUNT_DR_CR, t_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ACCOUNT_CODE = W_ACCOUNT_CODE    ;              

        --아래 if문은 사실상 같다. 단지 거래처 비교하는 부분만이 다르다. [예> AND CUSTOMER_CD IS NULL]
        IF W_CUSTOMER_CD = 'NONE' THEN        
        
            t_CUSTOMER_NM := '';

            --2.기초자료를 생성한다.
            --2-1.이월금액 기초자료 생성
        
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --조회일련번호
                , GL_DATE           --회계일자
                , REMARKS           --적요
                , DR_AMT            --차변(금액)
                , CR_AMT            --대변(금액)
                , REMAIN_AMT        --잔액
                , ACCOUNT_CODE      --계정코드
                , ACCOUNT_DESC      --계정명
                , CUSTOMER_CD       --거래처코드
                , CUSTOMER_NM       --거래처명
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호    
            )
            SELECT
                  1     --조회일련번호
                , NULL  --회계일자
                , '[이월금액]' AS REMARKS   --적요
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --차변
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --대변
                , 0                 --잔액       
                , W_ACCOUNT_CODE    --계정코드
                , t_ACCOUNT_DESC    --계정명
                , W_CUSTOMER_CD     --거래처코드
                , t_CUSTOMER_NM     --거래처명
                , NULL              --전표헤더아이디
                , NULL              --전표번호         
            FROM
                (
                    SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD IS NULL --else block안의 문장과 유일하게 다른부분
                        AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                    AND --이월금액 조회 종료일자는 
                                        CASE 
                                            --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                            WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                            ELSE W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                        END
                        AND SLIP_TYPE = --전표유형은
                                CASE 
                                    WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                    ELSE SLIP_TYPE   --모든 전표유형
                                END
                    GROUP BY CUSTOMER_CD, ACCOUNT_DR_CR
                )   ;  
                
            --2-2.조회기간 내 발생된 자료에 대한 기초자료 생성
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --조회일련번호
                , GL_DATE           --회계일자
                , REMARKS           --적요
                , DR_AMT            --차변(금액)
                , CR_AMT            --대변(금액)
                , REMAIN_AMT        --잔액
                , ACCOUNT_CODE      --계정코드
                , ACCOUNT_DESC      --계정명
                , CUSTOMER_CD       --거래처코드
                , CUSTOMER_NM       --거래처명
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호    
            )
            SELECT
                  ROWNUM + 1 AS ROW_NUM    --조회일련번호
                  
                --원 회계일자에 1초씩을 더해준다.
                --이유 : 동일 회계일자에 대해 GROUP BY ROOLUP이 적용되면 순서가 달라지는 문제를 해결하기 위험이다.
                , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --회계일자
                
                , REMARKS       --적요
                , DR_AMT     --차변
                , CR_AMT     --대변
                , 0 REMAIN_AMT      --잔액
                , W_ACCOUNT_CODE    --계정코드
                , t_ACCOUNT_DESC    --계정명
                , W_CUSTOMER_CD     --거래처코드
                , t_CUSTOMER_NM     --거래처명                                
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호              
            FROM(          
                    SELECT
                          GL_DATE       --회계일자                          
                        , REMARKS       --적요
                        , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --차변
                        , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --대변
                        , SLIP_HEADER_ID    --전표헤더아이디
                        , GL_NUM            --전표번호   
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD IS NULL --else block안의 문장과 유일하게 다른부분
                        AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                        AND SLIP_TYPE != 'BLS'  --전표유형은 '기초잔액'이 아닌것
                    ORDER BY GL_DATE
                )  ;            

        ELSE
        
            SELECT SUPP_CUST_NAME
            INTO t_CUSTOMER_NM   --거래처명
            FROM FI_SUPP_CUST_V
            WHERE SUPP_CUST_CODE = NVL(W_CUSTOMER_CD, SUPP_CUST_CODE)    ;

            --2.기초자료를 생성한다.
            --2-1.이월금액 기초자료 생성
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --조회일련번호
                , GL_DATE           --회계일자
                , REMARKS           --적요
                , DR_AMT            --차변(금액)
                , CR_AMT            --대변(금액)
                , REMAIN_AMT        --잔액
                , ACCOUNT_CODE      --계정코드
                , ACCOUNT_DESC      --계정명
                , CUSTOMER_CD       --거래처코드
                , CUSTOMER_NM       --거래처명
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호    
            )
            SELECT
                  1     --조회일련번호
                , NULL  --회계일자
                , '[이월금액]' AS REMARKS   --적요
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --차변
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --대변
                , 0                 --잔액       
                , W_ACCOUNT_CODE    --계정코드
                , t_ACCOUNT_DESC    --계정명
                , W_CUSTOMER_CD     --거래처코드
                , t_CUSTOMER_NM     --거래처명
                , NULL              --전표헤더아이디
                , NULL              --전표번호         
            FROM
                (
                    SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD = W_CUSTOMER_CD --if block안의 문장과 유일하게 다른부분
                        AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                    AND --이월금액 조회 종료일자는 
                                        CASE 
                                            --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                            WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                            ELSE W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                        END
                        AND SLIP_TYPE = --전표유형은
                                CASE 
                                    WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                    ELSE SLIP_TYPE   --모든 전표유형
                                END
                    GROUP BY CUSTOMER_CD, ACCOUNT_DR_CR
                )   ;
                
               
            --2-2.조회기간 내 발생된 자료에 대한 기초자료 생성
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --조회일련번호
                , GL_DATE           --회계일자
                , REMARKS           --적요
                , DR_AMT            --차변(금액)
                , CR_AMT            --대변(금액)
                , REMAIN_AMT        --잔액
                , ACCOUNT_CODE      --계정코드
                , ACCOUNT_DESC      --계정명
                , CUSTOMER_CD       --거래처코드
                , CUSTOMER_NM       --거래처명
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호    
            )
            SELECT
                  ROWNUM + 1 AS ROW_NUM    --조회일련번호
                  
                --원 회계일자에 1초씩을 더해준다.
                --이유 : 동일 회계일자에 대해 GROUP BY ROOLUP이 적용되면 순서가 달라지는 문제를 해결하기 위험이다.
                , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --회계일자
                
                , REMARKS       --적요
                , DR_AMT     --차변
                , CR_AMT     --대변
                , 0 REMAIN_AMT      --잔액
                , W_ACCOUNT_CODE    --계정코드
                , t_ACCOUNT_DESC    --계정명
                , W_CUSTOMER_CD     --거래처코드
                , t_CUSTOMER_NM     --거래처명                
                
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호            
            FROM(          
                    SELECT
                          GL_DATE       --회계일자                          
                        , REMARKS       --적요
                        , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --차변
                        , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --대변
                        , SLIP_HEADER_ID    --전표헤더아이디
                        , GL_NUM            --전표번호   
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD = W_CUSTOMER_CD --if block안의 문장과 유일하게 다른부분
                        AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                        AND SLIP_TYPE != 'BLS'  --전표유형은 '기초잔액'이 아닌것
                    ORDER BY GL_DATE
                )   ;             
           
        END IF;    

        

        --3.잔액을 수정한다.
        FOR AMT_MODIFY IN (
            SELECT RET_SEQ, DR_AMT, CR_AMT, REMAIN_AMT
            FROM FI_CUSTOMER_LEDGER
            ORDER BY RET_SEQ        
        ) LOOP 
            
            UPDATE FI_CUSTOMER_LEDGER
            SET REMAIN_AMT = DECODE(t_ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE RET_SEQ = AMT_MODIFY.RET_SEQ    ;
            
            
            SELECT DECODE(t_ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 



        --4. 세부자료 조회
        
        OPEN P_CURSOR FOR
        
        SELECT
              '' BASE_MM        --회계년월
            , GL_DATE           --회계일자
            , REMARKS           --적요
            , DR_AMT            --차변(금액)
            , CR_AMT            --대변(금액)
            , REMAIN_AMT        --잔액
            , ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , CUSTOMER_CD       --거래처코드
            , CUSTOMER_NM       --거래처명
            , SLIP_HEADER_ID    --전표헤더아이디
            , GL_NUM            --전표번호
        FROM FI_CUSTOMER_LEDGER
        WHERE RET_SEQ = 1

        UNION ALL
        
        SELECT
              TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
            , GL_DATE
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ 기 간 합 계 ]', DECODE(GROUPING(GL_DATE), 1, '[ 월    계 ]',  REMARKS)) AS REMARKS
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
            , REMAIN_AMT
            , ACCOUNT_CODE
            , ACCOUNT_DESC
            , CUSTOMER_CD
            , CUSTOMER_NM
            , SLIP_HEADER_ID
            , GL_NUM        
        FROM FI_CUSTOMER_LEDGER
        WHERE RET_SEQ > 1    
        GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, CUSTOMER_CD, CUSTOMER_NM, SLIP_HEADER_ID, GL_NUM))
        ;         

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         

    END; 
    
END DET_CUSTOMER_LEDGER;






--조회조건에서 선택한 조회할 계정목록 중 자료가 있는 계정만 보여준다.
PROCEDURE LIST_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ACCOUNT_CONTROL.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_ACCOUNT_CONTROL.ORG_ID%TYPE
    , W_ACCOUNT_SET_ID  IN  FI_ACCOUNT_CONTROL.ACCOUNT_SET_ID%TYPE
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료      
    , W_ACCOUNT_FR      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_ACCOUNT_TO      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --거래처코드
)

AS

BEGIN


    --특정거래처를 지정하지 않은 경우
    IF NVL(W_CUSTOMER_CD, 'NONE') = 'NONE' THEN
        
        OPEN P_CURSOR FOR
           
        SELECT
              A.ACCOUNT_CODE  --계정코드
            , B.ACCOUNT_DESC  --계정명
            , A.CNT           --자료건수    
            , DECODE(B.ACCOUNT_DR_CR, '1', '차변', '2', '대변') AS ACCOUNT_DR_CR --계정성격
        FROM
            (
                SELECT 
                      ACCOUNT_CODE
                    , COUNT(*) CNT
                FROM FI_CUSTOMER_LEDGER_V
                WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                    AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                    --AND CUSTOMER_CD = NVL(W_CUSTOMER_CD, CUSTOMER_CD) ; 이 부분만이 ELSE문과 다르다.
                GROUP BY ACCOUNT_CODE  
            ) A    
            , (
                SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
                FROM FI_ACCOUNT_CONTROL A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                    --AND ENABLED_FLAG = 'Y'
            ) B 
        WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
        ORDER BY ACCOUNT_CODE   ;    
    
    ELSE    --특정거래처를 지정한 경우
        
        OPEN P_CURSOR FOR
           
        SELECT
              A.ACCOUNT_CODE  --계정코드
            , B.ACCOUNT_DESC  --계정명
            , A.CNT           --자료건수    
            , DECODE(B.ACCOUNT_DR_CR, '1', '차변', '2', '대변') AS ACCOUNT_DR_CR --계정성격
        FROM
            (
                SELECT 
                      ACCOUNT_CODE
                    , COUNT(*) CNT
                FROM FI_CUSTOMER_LEDGER_V
                WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                    AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                    AND CUSTOMER_CD = W_CUSTOMER_CD --이 부분만이 IF문과 다르다.
                GROUP BY ACCOUNT_CODE  
            ) A    
            , (
                SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
                FROM FI_ACCOUNT_CONTROL A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                    --AND ENABLED_FLAG = 'Y'
            ) B 
        WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
        ORDER BY ACCOUNT_CODE   ;    
    
    END IF;



END LIST_ACCOUNT;





END FI_CUSTOMER_LEDGER_G;
/
