CREATE OR REPLACE PACKAGE FI_MANAGEMENT_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_MANAGEMENT_LEDGER_G
Description  : 관리항목별원장조회 Package

Reference by : calling assmbly-program id(호출 프로그램) : (관리항목별원장조회)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-14   Leem Dong Ern(임동언)
*****************************************************************************/




--상단 합계내역 조회
PROCEDURE UP_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR        IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE        IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드
    
    --아래 2 PARAMETER는 공통코드(FI_COMMON)에서 참조하는 동일한 자료에 대한 값이다.
    --이렇게 2개로 한 이유는 본 PROCEDURE 내에서 자료 추출을 편리하게 하기 위함일 뿐이다.
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2 --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
    
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
);





--합계자료에 조회된 자료 중 관리항목 코드에 해당하는 관리항목명 수정
--참조>화면 관리항목 조건 POPUP창에서 선택한 항목에 대한 세부 자료 추출하는 LIST_MANAGEMENT_GUBUN PROCEDURE와 동일한 맥락이다.
--이 PROCEDURE는 [기말차기이월작업 : FI_FORWARD_AMT_G > UPD_MANAGEMENT_NM] 프로그램에서 그 논리를 동일하게 이용하고 있다.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
);






--하단 상세내역 조회
PROCEDURE DET_MANAGEMENT_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_CD   IN  FI_MANAGEMENT_LEDGER_SUM.MANAGEMENT_CD%TYPE   --관리항목_코드
);



--관리항목별 원장 전체내역 조회
PROCEDURE ALL_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR        IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE_FR     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드
    , W_ACCOUNT_CODE_TO     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
);



--관리항목 리스트
PROCEDURE LIST_MANAGEMENT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_COMMON.ORG_ID%TYPE
);





--화면 관리항목 조건 POPUP창에서 선택한 항목에 대한 세부 자료 추출
--참조>합계자료에 조회된 자료 중 관리항목 코드에 해당하는 관리항목명을 수정하는 UPD_MANAGEMENT_NM PROCEDURE와 동일한 맥락이다.
PROCEDURE LIST_MANAGEMENT_GUBUN( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID              IN  FI_COMMON.ORG_ID%TYPE
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2
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
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목_아이디
    , W_MANAGEMENT_VAL  IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
);





END FI_MANAGEMENT_LEDGER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MANAGEMENT_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_MANAGEMENT_LEDGER_G
Description  : 관리항목별원장조회 Package

Reference by : calling assmbly-program id(호출 프로그램) : (관리항목별원장조회)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-14   Leem Dong Ern(임동언)
*****************************************************************************/




--상단 합계내역 조회
PROCEDURE UP_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR        IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE        IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드 
    
    --아래 2 PARAMETER는 공통코드(FI_COMMON)에서 참조하는 동일한 자료에 대한 값이다.
    --이렇게 2개로 한 이유는 본 PROCEDURE 내에서 자료 추출을 편리하게 하기 위함일 뿐이다.
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2 --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
    
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;  --차대구분(1-차변,2-대변)
t_ACCOUNT_DESC      FI_ACCOUNT_CONTROL.ACCOUNT_DESC%TYPE;   --계정명

t_FORWARD_AMT       FI_MANAGEMENT_LEDGER_SUM.FORWARD_AMT%TYPE;  --이월금액
t_REMAIN_AMT        FI_MANAGEMENT_LEDGER_SUM.REMAIN_AMT%TYPE;   --잔액

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
            


        --기존자료를 삭제한다.
        DELETE FROM FI_MANAGEMENT_LEDGER_SUM;
        
        --기초자료를 생성한다.
        INSERT INTO FI_MANAGEMENT_LEDGER_SUM(
              ACCOUNT_CODE  --계정코드
            , ACCOUNT_DESC  --계정명
            , ACCOUNT_DR_CR --(금액)차대구분
            , MANAGEMENT_CD --관리항목_코드
            , MANAGEMENT_NM --관리항목_명
            , FORWARD_AMT   --이월금액
            , INC_AMT       --증가금액
            , DEC_AMT       --감소금액
            , REMAIN_AMT    --잔액   
        )    
        SELECT  
              W_ACCOUNT_CODE AS ACCOUNT_CODE    --계정코드
            , t_ACCOUNT_DESC AS ACCOUNT_DESC    --계정명
            , t_ACCOUNT_DR_CR AS ACCOUNT_DR_CR  --차대구분
            , MANAGEMENT_VAL AS MANAGEMENT_CD   --관리항목_코드        
            , '' AS MANAGEMENT_NM               --관리항목_명        
            , 0 AS FORWARD_AMT                  --이월금액
            , NVL(INC_AMT, 0) AS INC_AMT        --증가
            , NVL(DEC_AMT, 0) AS DEC_AMT        --감소
            , 0 AS REMAIN_AMT --잔액         
        FROM
            (
                SELECT 
                      A.MANAGEMENT_VAL --관리항목_코드
                    
                    --이월금액 : 조회시작년 1월 1일 ~ 조회시작일 전일 까지의 금액 합계
                    , 0 FORWARD_AMT --이월금액

                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN C.GL_AMOUNT --차변이면
                        WHEN '2' THEN D.GL_AMOUNT --대변이면
                    END INC_AMT --증가
                    
                    , CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                        WHEN '1' THEN D.GL_AMOUNT --차변이면
                        WHEN '2' THEN C.GL_AMOUNT --대변이면
                    END DEC_AMT --감소                
                FROM
                    (   --조회기간(시작일은 조회시작일의 년의 1월1일자이다.)과 조회 계정에 부합되는 자료를 추출한다.
                        --조회시작일을 1월 1일로 하는 이유는 조회되는 자료를 재무상태표와 일치하기 위해서이다.
                        SELECT MANAGEMENT_VAL
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                        GROUP BY MANAGEMENT_VAL                    
                    ) A
                    
                    --QUERY기능적참조>C, D 테이블을 1개의 테이블로 합할 수도 있는데 가독성을 배가하고,
                    --그 속도면에서도 차이가 없어 현재처럼 2개의 테이블로 했다.                
                    , ( --차변금액
                        SELECT
                              MANAGEMENT_VAL
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID                 
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 1   --차변
                        GROUP BY MANAGEMENT_VAL                                     
                        ) C
                    , ( --대변금액
                        SELECT
                              MANAGEMENT_VAL
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                            AND SLIP_TYPE != 'BLS'  --전표유형이 '기초잔액'이 아닌 자료만
                            AND ACCOUNT_DR_CR = 2   --대변
                        GROUP BY MANAGEMENT_VAL
                        ) D       
                WHERE A.MANAGEMENT_VAL = C.MANAGEMENT_VAL(+) 
                    AND A.MANAGEMENT_VAL = D.MANAGEMENT_VAL(+) 
            ) T 
        ORDER BY MANAGEMENT_VAL ;

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
            
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');                    
    END;




    --조회된 자료에 대한 [관리항목_명]을 수정한다.

/*
    아래 3개의 구분값은 화면의 관리항목 조건에서 POPUP을 통해 그 값을 선택할 수 있는 자료이나, 번호 성격으로 그 명을 수정하는 처리를 안한다. 
    --, 'PAYABLE_BILL'    --지급어음번호(35)            [TABLE : FI_PAYABLE_BILL]
    --, 'RECEIVABLE_BILL' --받을어음번호(21)            [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    --, 'LC_NO'           --L/C번호(32)                 [TABLE : FI_LC_MASTER, FI_BANK, FI_SUPP_CUST_V] 
*/

    IF W_MANAGEMENT_GUBUN IN (
              'BANK'            --금융기관(23)                [TABLE : FI_BANK]
            , 'CUSTOMER'        --거래처(01)                  [TABLE : FI_SUPP_CUST_V]
            , 'BANK_ACCOUNT'    --계좌번호(03)                [TABLE : FI_BANK_ACCOUNT]
            , 'CREDIT_CARD'     --결제카드, 카드번호(02, 26)  [TABLE : FI_CREDIT_CARD]
            , 'PERSON_NUM'      --사원(11)                    [TABLE : HRM_PERSON_MASTER]
            , 'DEPT'            --부서(08)                    [TABLE : FI_DEPT_MASTER]
            , 'COSTCENTER'      --원가코드(27)                [TABLE : CST_COST_CENTER]           
            
            , 'BILL_STATUS'             --어음처리구분(07)               [TABLE : FI_COMMON]
            , 'TAX_CODE'                --사업장(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --부가세대급금_사유구분(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --부가세대급금_세무유형(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --부가세예수금_세무유형(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --예정신고누락분여부(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --수정전자세금계산서사유구분(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --타계정구분(38)                 [TABLE : FI_COMMON]
        ) THEN
        
        UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_MANAGEMENT_GUBUN);
        
    ELSE
        NULL;
    END IF;



    --이월금액과 잔액을 보정한 후 최종자료를 조회한다. 
    OPEN P_CURSOR FOR

    SELECT  
          DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.ACCOUNT_CODE) AS ACCOUNT_CODE    --계정코드
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.ACCOUNT_DESC) AS ACCOUNT_DESC    --계정명
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', DECODE(T.ACCOUNT_DR_CR, '1', '차변', 2, '대변')) AS ACCOUNT_DR_CR   --차대구분
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.MANAGEMENT_CD) AS MANAGEMENT_CD    --관리항목_코드
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', DECODE(T.MANAGEMENT_CD, 'NONE', '', T.MANAGEMENT_CD)) AS VIEW_MANAGEMENT_CD    --관리항목_코드(화면에 보여지는 것)
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '   [  총   계  ]', T.MANAGEMENT_NM) AS MANAGEMENT_NM  --관리항목_명
        
        , SUM(NVL(B.FORWARD_AMT, 0)) AS FORWARD_AMT    --이월금액
        , SUM(NVL(T.INC_AMT, 0)) AS INC_AMT            --증가
        , SUM(NVL(T.DEC_AMT, 0)) AS DEC_AMT            --감소
        , SUM(NVL(B.FORWARD_AMT, 0) + NVL(T.INC_AMT, 0) - NVL(T.DEC_AMT, 0)) AS REMAIN_AMT --잔액 
    FROM FI_MANAGEMENT_LEDGER_SUM T
        , (  
            SELECT
                  A.ACCOUNT_CODE
                , A.MANAGEMENT_CD

                --이월금액 : 조회시작년 1월 1일 ~ 조회시작일 전일 까지의 금액 합계
                , C.FORWARD_AMT --이월금액                
            FROM FI_MANAGEMENT_LEDGER_SUM A --조회 자료의 기준 테이블
                , ( --기준 자료의 코드에 부합되는 이월금액 추출 테이블
                    SELECT
                        MANAGEMENT_VAL,
                        CASE t_ACCOUNT_DR_CR  --선택한 계정의 차대구분 속성이
                            WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --차변이면
                            WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --대변이면
                        END FORWARD_AMT
                    FROM FI_MANAGEMENT_LEDGER_V 
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND MANAGEMENT_ID = W_MANAGEMENT_ID
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
                    GROUP BY MANAGEMENT_VAL    
                ) C
            WHERE A.MANAGEMENT_CD  = C.MANAGEMENT_VAL(+)            
        ) B
    WHERE T.MANAGEMENT_CD = B.MANAGEMENT_CD
    GROUP BY ROLLUP( ( T.ACCOUNT_CODE, T.ACCOUNT_DESC, T.ACCOUNT_DR_CR, T.MANAGEMENT_CD, T.MANAGEMENT_NM, B.FORWARD_AMT, T.INC_AMT, T.DEC_AMT) )
    ORDER BY MANAGEMENT_CD
    ;


END UP_MANAGEMENT_LEDGER;






--합계자료에 조회된 자료 중 관리항목 코드에 해당하는 관리항목명 수정
--참조>화면 관리항목 조건 POPUP창에서 선택한 항목에 대한 세부 자료 추출하는 LIST_MANAGEMENT_GUBUN PROCEDURE와 동일한 맥락이다.
--이 PROCEDURE는 [기말차기이월작업 : FI_FORWARD_AMT_G > UPD_MANAGEMENT_NM] 프로그램에서 그 논리를 동일하게 이용하고 있다.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.
)

AS

BEGIN
   

--연관 프로시져 : FI_ACCOUNT_CONTROL_G > LU_CONTROL_ITEM / LU_MANAGEMENT_ITEM
--위 2 프로시져는 동일한 내용인데, 파리미터만 다를뿐이다.

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --금융기관(23)   [TABLE : FI_BANK]
    
        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT BANK_NAME
                                FROM FI_BANK
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND BANK_GROUP != '-' 
                                    AND BANK_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --거래처(01)   [TABLE : FI_SUPP_CUST_V]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT SUPP_CUST_NAME
                                FROM FI_SUPP_CUST_V
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND SUPP_CUST_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
    
    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --계좌번호(03)  [TABLE : FI_BANK_ACCOUNT]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                FROM FI_BANK_ACCOUNT
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND BANK_ACCOUNT_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
       
    ELSIF W_MANAGEMENT_GUBUN = 'PAYABLE_BILL' THEN      --지급어음번호(35)    [TABLE : FI_PAYABLE_BILL]

        NULL;   --자료도 없고, 무언가 부정확하여 처리안한다.
    
    ELSIF W_MANAGEMENT_GUBUN = 'RECEIVABLE_BILL' THEN   --받을어음번호(21)    [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    
        NULL;   --POPUP으로 처리하는 걸로 되어있지만 실상은 전표등록 시 직접 KEY-IN한다.
    
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --결제카드, 카드번호(02, 26)  [TABLE : FI_CREDIT_CARD]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT CARD_NUM
                                FROM FI_CREDIT_CARD
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CARD_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --사원(11)    [TABLE : HRM_PERSON_MASTER]
    
        UPDATE FI_MANAGEMENT_LEDGER_SUM T
        SET MANAGEMENT_NM = (
                SELECT NAME
                FROM HRM_PERSON_MASTER A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND CORP_TYPE = '1'
                    AND PERSON_NUM = T.MANAGEMENT_CD
                    AND EXISTS (  SELECT 'X'
                                  FROM HRM_CORP_MASTER
                                  WHERE SOB_ID       = A.SOB_ID
                                    AND ORG_ID       = A.ORG_ID
                                    AND CORP_ID      = A.CORP_ID
                                    AND DEFAULT_FLAG = 'Y'
                             )
                )
        WHERE MANAGEMENT_CD != 'NONE'   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --부서(08)    [TABLE : FI_DEPT_MASTER]        

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --원가코드(27)  [TABLE : CST_COST_CENTER]        

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;      

    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C번호(32) [TABLE : FI_LC_MASTER]
    
        NULL;   --L/C번호 자체로 의미있는 자료지 더 이상의 설명이 필요없다 판단했다.
    
    ELSE
        /*
            , 'BILL_STATUS'             --어음처리구분(07)               [TABLE : FI_COMMON]
            , 'TAX_CODE'                --사업장(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --부가세대급금_사유구분(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --부가세대급금_세무유형(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --부가세예수금_세무유형(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --예정신고누락분여부(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --수정전자세금계산서사유구분(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --타계정구분(38)                 [TABLE : FI_COMMON]
        */

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
           
    END IF;
    
END UPD_MANAGEMENT_NM;









--하단 상세내역 조회
PROCEDURE DET_MANAGEMENT_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR    IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --계정코드   
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_CD   IN  FI_MANAGEMENT_LEDGER_SUM.MANAGEMENT_CD%TYPE   --관리항목_코드
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;      --차대구분(1-차변,2-대변)
t_ACCOUNT_DESC      FI_CUSTOMER_LEDGER.ACCOUNT_DESC%TYPE;       --계정명
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
            , SLIP_LINE_ID      --전표라인ID
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
            , NULL  --거래처코드
            , NULL  --거래처명
            , NULL  --전표헤더아이디
            , NULL  --전표번호 
            , NULL  --전표라인ID
        FROM
            (
                SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                FROM FI_MANAGEMENT_LEDGER_V
                WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                    AND MANAGEMENT_ID = W_MANAGEMENT_ID
                    AND MANAGEMENT_VAL = W_MANAGEMENT_CD
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
                GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
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
            , SLIP_LINE_ID      --전표라인ID
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
            , NULL     --거래처코드
            , NULL     --거래처명
            , SLIP_HEADER_ID    --전표헤더아이디            
            , GL_NUM            --전표번호
            , SLIP_LINE_ID      --전표라인ID                
        FROM
        (
            SELECT
                  GL_DATE       --회계일자
                , REMARKS       --적요
                , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --차변
                , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --대변
                , SLIP_HEADER_ID    --전표헤더아이디
                , GL_NUM            --전표번호
                , SLIP_LINE_ID      --전표라인ID
            FROM FI_MANAGEMENT_LEDGER_V
            WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                AND MANAGEMENT_ID = W_MANAGEMENT_ID
                AND MANAGEMENT_VAL = W_MANAGEMENT_CD
                AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                AND SLIP_TYPE != 'BLS'  --전표유형은 '기초잔액'이 아닌것
            ORDER BY GL_DATE    
        )   ;                   



    EXCEPTION
        WHEN OTHERS THEN
            NULL;
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         

    END; 




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



    --대상 자료에 거래처자료가 있다면 거래처코드를 수정한다.
    UPDATE FI_CUSTOMER_LEDGER T
    SET CUSTOMER_CD = 
        (
            SELECT A.CUSTOMER_CD
            FROM FI_CUSTOMER_LEDGER_V A
                , (
                    SELECT RET_SEQ, SLIP_LINE_ID, ACCOUNT_CODE
                    FROM FI_CUSTOMER_LEDGER
                    WHERE SLIP_LINE_ID IS NOT NULL
                ) B
            WHERE A.SLIP_LINE_ID = B.SLIP_LINE_ID
                AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
                AND B.RET_SEQ = T.RET_SEQ    
        )
    WHERE GL_NUM IS NOT NULL    ;



    --5. 세부자료 조회
    
    OPEN P_CURSOR FOR

    SELECT
          '' BASE_MM        --회계년월
        , GL_DATE           --회계일자
        , REMARKS           --적요
        , CUSTOMER_CD       --거래처코드
        , CUSTOMER_NM       --거래처명            
        , DR_AMT            --차변(금액)
        , CR_AMT            --대변(금액)
        , REMAIN_AMT        --잔액
        , ACCOUNT_CODE      --계정코드
        , ACCOUNT_DESC      --계정명
        , SLIP_HEADER_ID    --전표헤더아이디
        , GL_NUM            --전표번호
        , SLIP_LINE_ID      --전표라인아이디
    FROM FI_CUSTOMER_LEDGER
    WHERE RET_SEQ = 1

    UNION ALL
    
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ 기 간 합 계 ]', DECODE(GROUPING(GL_DATE), 1, '[ 월    계 ]',  REMARKS)) AS REMARKS
        , CUSTOMER_CD
        , B.SUPP_CUST_NAME AS CUSTOMER_NM            
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
        , REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_CUSTOMER_LEDGER A
        , FI_SUPP_CUST_V B  --대상 자료에 거래처자료가 있다면 거래처명을 조회시켜주기 위함이다.
    WHERE RET_SEQ > 1
        AND A.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
    GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, CUSTOMER_CD, B.SUPP_CUST_NAME, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID))
    ;

    
END DET_MANAGEMENT_LEDGER;


--관리항목별 원장 전체내역 조회
PROCEDURE ALL_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_DEAL_DATE_FR        IN  DATE    --조회기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --조회기간_종료    
    , W_ACCOUNT_CODE_FR     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드
    , W_ACCOUNT_CODE_TO     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --계정코드
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목아이디
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
)
AS
  t_REMAIN_AMT  NUMBER := 0;
  t_LOOKUP_TYPE VARCHAR2(50);
  v_USER_ID     NUMBER := GET_USER_ID_F;
BEGIN
  
    -- 2-0. 기존자료 삭제.
    DELETE FROM FI_MANAGEMENT_LEDGER_DETAIL 
    WHERE USER_ID    = v_USER_ID;
    
    -- LOOKUP TYPE.
    BEGIN
      SELECT MC.LOOKUP_TYPE
        INTO t_LOOKUP_TYPE
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID      = W_MANAGEMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      t_LOOKUP_TYPE := NULL;
    END;
    
    FOR C1 IN ( SELECT ROWNUM * 10000 AS ROW_NUM
                     , AC.ACCOUNT_CONTROL_ID
                     , AC.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AC.ACCOUNT_DR_CR
                     , AC.SOB_ID
                  FROM FI_ACCOUNT_CONTROL AC
                WHERE AC.ACCOUNT_CODE     BETWEEN W_ACCOUNT_CODE_FR AND W_ACCOUNT_CODE_TO
                  AND AC.SOB_ID           = W_SOB_ID
                  AND AC.ENABLED_FLAG     = 'Y'
              )
    LOOP
        --2-1.이월금액 기초자료 생성
        MERGE INTO FI_MANAGEMENT_LEDGER_DETAIL MLD
        USING ( SELECT
                      1 AS RET_SEQ              --조회일련번호;
                    , W_DEAL_DATE_FR AS GL_DATE --회계일자;
                    , '[이월금액]' AS REMARKS   --적요;
                    , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --차변;
                    , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --대변;
                    , 0 AS REMAIN_AMT           --잔액;
                    , v_USER_ID AS USER_ID      -- 접속자 ID;
                FROM
                    (
                        SELECT ML.ACCOUNT_DR_CR, SUM(ML.GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V ML
                        WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                            AND ML.MANAGEMENT_ID    = W_MANAGEMENT_ID
                            AND ((W_MANAGEMENT_VAL  IS NULL AND 1 = 1)
                            OR   (W_MANAGEMENT_VAL  IS NOT NULL AND ML.MANAGEMENT_VAL = W_MANAGEMENT_VAL))
                            AND ML.GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                           AND --이월금액 조회 종료일자는 
                                              CASE 
                                                  --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                                  WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                  ELSE W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                              END
                            AND ML.SLIP_TYPE = --전표유형은
                                              CASE 
                                                  WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                                  ELSE SLIP_TYPE   --모든 전표유형
                                              END
                        GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
                    )
              ) SX1
        ON    ( MLD.RET_SEQ        = SX1.RET_SEQ
           AND  MLD.GL_DATE        = SX1.GL_DATE
           AND  MLD.USER_ID        = SX1.USER_ID 
              )
        WHEN MATCHED THEN
          UPDATE 
            SET MLD.DR_AMT         = NVL(MLD.DR_AMT, 0) + NVL(SX1.DR_AMT, 0)
              , MLD.CR_AMT         = NVL(MLD.CR_AMT, 0) + NVL(SX1.CR_AMT, 0)
              , MLD.REMAIN_AMT     = NVL(MLD.REMAIN_AMT, 0) + NVL(SX1.REMAIN_AMT, 0)
        WHEN NOT MATCHED THEN
          INSERT
          ( RET_SEQ           --조회일련번호,
          , GL_DATE           --회계일자,
          , REMARKS           --적요,
          , DR_AMT            --차변(금액),
          , CR_AMT            --대변(금액),
          , REMAIN_AMT        --잔액,
          , ACCOUNT_CODE      --계정코드,
          , ACCOUNT_DESC      --계정명,
          , MANAGEMENT_CD     --관리항목코드,
          , MANAGEMENT_NM     --관리항목명,
          , SLIP_HEADER_ID    --전표헤더아이디,
          , GL_NUM            --전표번호,
          , SLIP_LINE_ID      --전표라인ID,
          , USER_ID
        ) VALUES
        ( SX1.RET_SEQ         -- 조회일련번호.
        , SX1.GL_DATE         -- 회계일자.
        , SX1.REMARKS         -- 적요.
        , NVL(SX1.DR_AMT, 0)  -- 차변금액.
        , NVL(SX1.CR_AMT, 0)  -- 대변금액.
        , NVL(SX1.REMAIN_AMT, 0) -- 잔액.
        , NULL                -- 계정코드.
        , NULL                -- 계정명.
        , NULL                -- 관리항목코드.
        , NULL                -- 관리항목명.
        , NULL                -- 전표헤더아이디.
        , NULL                -- 전표번호.
        , NULL                -- 전표라인ID.
        , SX1.USER_ID         -- USER ID 
        )
        ;
                
        --2-2.조회기간 내 발생된 자료에 대한 기초자료 생성
        INSERT /*+ NOLOGGING*/ INTO FI_MANAGEMENT_LEDGER_DETAIL(
              RET_SEQ           --조회일련번호
            , GL_DATE           --회계일자
            , REMARKS           --적요
            , DR_AMT            --차변(금액)
            , CR_AMT            --대변(금액)
            , REMAIN_AMT        --잔액
            , ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , MANAGEMENT_CD     --거래처코드
            , MANAGEMENT_NM     --거래처명
            , SLIP_HEADER_ID    --전표헤더아이디
            , GL_NUM            --전표번호
            , SLIP_LINE_ID      --전표라인ID
            , USER_ID
        )
        SELECT
              C1.ROW_NUM + ROWNUM AS ROW_NUM    --조회일련번호.
            --원 회계일자에 1초씩을 더해준다.
            --이유 : 동일 회계일자에 대해 GROUP BY ROOLUP이 적용되면 순서가 달라지는 문제를 해결하기 위험이다.
            , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --회계일자 .
            , REMARKS           --적요.
            , DR_AMT            --차변.
            , CR_AMT            --대변.
            , 0 REMAIN_AMT      --잔액.
            , ACCOUNT_CODE      --계정코드.
            , ACCOUNT_DESC      --계정명.
            , MANAGEMENT_VAL    --관리항목코드.
            , NULL              --거래처명.
            , SLIP_HEADER_ID    --전표헤더아이디.
            , GL_NUM            --전표번호.
            , SLIP_LINE_ID      --전표라인ID.
            , v_USER_ID         -- USER ID. 
        FROM
        (
            SELECT
                  ML.GL_DATE       --회계일자
                , ML.REMARKS       --적요
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '1', ML.GL_AMOUNT, 0), 0) AS DR_AMT     --차변
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '2', ML.GL_AMOUNT, 0), 0) AS CR_AMT     --대변
                , C1.ACCOUNT_CODE
                , C1.ACCOUNT_DESC
                , ML.MANAGEMENT_VAL
                , ML.SLIP_HEADER_ID    --전표헤더아이디
                , ML.GL_NUM            --전표번호
                , ML.SLIP_LINE_ID      --전표라인ID
            FROM FI_MANAGEMENT_LEDGER_V ML
            WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
              AND ML.MANAGEMENT_ID      = W_MANAGEMENT_ID
              AND ((W_MANAGEMENT_VAL    IS NULL AND 1 = 1)
              OR   (W_MANAGEMENT_VAL    IS NOT NULL AND ML.MANAGEMENT_VAL = W_MANAGEMENT_VAL))
              AND ML.GL_DATE            BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
              AND ML.BLS_FLAG           = 'N' --전표유형은 '기초잔액'이 아닌것
            ORDER BY ML.GL_DATE
        )   ;                   

        --3.잔액을 수정한다.
        t_REMAIN_AMT := 0;
        FOR AMT_MODIFY IN (
            SELECT MLD.RET_SEQ, C1.ACCOUNT_DR_CR, MLD.DR_AMT, MLD.CR_AMT, MLD.REMAIN_AMT
              FROM FI_MANAGEMENT_LEDGER_DETAIL MLD
            WHERE MLD.USER_ID           = v_USER_ID
            ORDER BY RET_SEQ
        ) LOOP 
            
            UPDATE FI_MANAGEMENT_LEDGER_DETAIL ML
            SET ML.REMAIN_AMT = DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE ML.RET_SEQ = AMT_MODIFY.RET_SEQ    
              AND ML.USER_ID = v_USER_ID;
            
            
            SELECT DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 

        --대상 자료에 거래처자료가 있다면 거래처코드를 수정한다.
        UPDATE FI_MANAGEMENT_LEDGER_DETAIL T
        SET T.MANAGEMENT_NM = FI_ACCOUNT_CONTROL_G.ITEM_DESC_F(t_LOOKUP_TYPE, T.MANAGEMENT_CD, 10)
        WHERE GL_NUM          IS NOT NULL
          AND T.USER_ID       = v_USER_ID;
    END LOOP C1;
    
    OPEN P_CURSOR FOR
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , CASE
            WHEN RET_SEQ = 1 THEN NULL
            ELSE GL_DATE
          END AS GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ 기 간 합 계 ]', DECODE(GROUPING(GL_DATE), 1, '[ 월    계 ]',  REMARKS)) AS REMARKS
        , MANAGEMENT_CD
        , MANAGEMENT_NM
        , SUM(DR_AMT) AS DR_AMT
        , SUM(CR_AMT) AS CR_AMT
        , REMAIN_AMT AS REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE ML.USER_ID          = v_USER_ID
    GROUP BY ROLLUP((TO_CHAR(GL_DATE, 'YYYY-MM')), 
          (GL_DATE, REMARKS, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, MANAGEMENT_CD, MANAGEMENT_NM, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID, RET_SEQ))
    ;
END ALL_MANAGEMENT_LEDGER;



--관리항목 리스트
PROCEDURE LIST_MANAGEMENT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_COMMON.ORG_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT 
          CODE_NAME --관리항목명
        , CODE      --코드
        , COMMON_ID --아이디
        , VALUE3 AS MANAGEMENT_GUBUN    --이 항목에 있는 값을 이용하여 [관리항목_명]을 구한다.        
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GROUP_CODE = 'MANAGEMENT_CODE'
        AND ENABLED_FLAG = 'Y'
    ORDER BY CODE   ;

END LIST_MANAGEMENT;








--화면 관리항목 조건 POPUP창에서 선택한 항목에 대한 세부 자료 추출
--참조>합계자료에 조회된 자료 중 관리항목 코드에 해당하는 관리항목명을 수정하는 UPD_MANAGEMENT_NM PROCEDURE와 동일한 맥락이다.
PROCEDURE LIST_MANAGEMENT_GUBUN( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID              IN  FI_COMMON.ORG_ID%TYPE
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2
)

AS

BEGIN    

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --금융기관(23)   [TABLE : FI_BANK]
    
        OPEN P_CURSOR FOR
        
        SELECT BANK_CODE AS CODE
            , BANK_NAME AS NAME
        FROM FI_BANK
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND BANK_GROUP != '-' 
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --거래처(01)   [TABLE : FI_SUPP_CUST_V]
    
        OPEN P_CURSOR FOR
        
        SELECT SUPP_CUST_CODE AS CODE
            , SUPP_CUST_NAME AS NAME
        FROM FI_SUPP_CUST_V
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --계좌번호(03)  [TABLE : FI_BANK_ACCOUNT]
    
        OPEN P_CURSOR FOR
        
        SELECT BANK_ACCOUNT_CODE AS CODE
            , BANK_ACCOUNT_NUM AS NAME
        FROM FI_BANK_ACCOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        
       
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --결제카드, 카드번호(02, 26)  [TABLE : FI_CREDIT_CARD]
    
        OPEN P_CURSOR FOR

        SELECT CARD_CODE AS CODE
            , CARD_NUM AS NAME
        FROM FI_CREDIT_CARD
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --사원(11)    [TABLE : HRM_PERSON_MASTER]
    
        OPEN P_CURSOR FOR

        SELECT PERSON_NUM AS CODE
            , NAME AS NAME
        FROM HRM_PERSON_MASTER A
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND CORP_TYPE = '1'
            AND EXISTS (  SELECT 'X'
                          FROM HRM_CORP_MASTER
                          WHERE SOB_ID       = A.SOB_ID
                            AND ORG_ID       = A.ORG_ID
                            AND CORP_ID      = A.CORP_ID
                            AND DEFAULT_FLAG = 'Y'
                        )
        ORDER BY CODE   ;                    
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --부서(08)    [TABLE : FI_DEPT_MASTER]  
    
        OPEN P_CURSOR FOR

        SELECT DEPT_CODE AS CODE
            , DEPT_NAME AS NAME
        FROM FI_DEPT_MASTER
        WHERE SOB_ID = W_SOB_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --원가코드(27)  [TABLE : CST_COST_CENTER] 
    
        OPEN P_CURSOR FOR

        SELECT COST_CENTER_CODE AS CODE
            , COST_CENTER_DESC AS NAME
        FROM CST_COST_CENTER
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C번호(32) [TABLE : FI_LC_MASTER]
        
        OPEN P_CURSOR FOR
        
        SELECT LM.LC_NUM AS CODE
            , FB.BANK_NAME ||  DECODE(SC.SUPP_CUST_NAME, NULL, '', '(' || SC.SUPP_CUST_NAME || ')') AS NAME 
        FROM FI_LC_MASTER LM
            , FI_BANK FB
            , FI_SUPP_CUST_V SC
        WHERE LM.SOB_ID = W_SOB_ID
            AND LM.ORG_ID = W_ORG_ID
            AND LM.BANK_ID = FB.BANK_ID
            AND LM.SUPPLIER_ID = SC.SUPP_CUST_ID(+)
        ORDER BY CODE   ;        
            
    ELSIF W_MANAGEMENT_GUBUN IN (
                  'BILL_STATUS'             --어음처리구분(07)               [TABLE : FI_COMMON]
                , 'TAX_CODE'                --사업장(10)                     [TABLE : FI_COMMON]
                , 'VAT_REASON'              --부가세대급금_사유구분(12)      [TABLE : FI_COMMON]
                , 'VAT_TYPE_AP'             --부가세대급금_세무유형(13)      [TABLE : FI_COMMON]
                , 'VAT_TYPE_AR'             --부가세예수금_세무유형(33)      [TABLE : FI_COMMON]
                , 'SCHEDULE_REPORT_OMIT'    --예정신고누락분여부(36)         [TABLE : FI_COMMON]
                , 'MODIFY_TAX_REASON'       --수정전자세금계산서사유구분(37) [TABLE : FI_COMMON]
                , 'OTHER_ACCOUNT_GB'        --타계정구분(38)                 [TABLE : FI_COMMON]
            )  THEN
    
        OPEN P_CURSOR FOR

        SELECT CODE AS CODE
            , CODE_NAME AS NAME
        FROM FI_COMMON
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND GROUP_CODE = W_MANAGEMENT_GUBUN
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;
        
    ELSE
    
        OPEN P_CURSOR FOR

        SELECT '' AS CODE
            , '' AS NAME
        FROM DUAL    ;
           
    END IF;

END LIST_MANAGEMENT_GUBUN;









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
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --관리항목_아이디
    , W_MANAGEMENT_VAL  IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --선택한 관리항목에 따른 특정 코드값
)

AS

BEGIN

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
            FROM FI_MANAGEMENT_LEDGER_V
            WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                AND MANAGEMENT_ID = W_MANAGEMENT_ID
                AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
            GROUP BY ACCOUNT_CODE  
        ) A    
        , (
            SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
            FROM FI_ACCOUNT_CONTROL A
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                AND ENABLED_FLAG = 'Y'
        ) B 
    WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
    ORDER BY ACCOUNT_CODE   ;

END LIST_ACCOUNT;







END FI_MANAGEMENT_LEDGER_G;
/
