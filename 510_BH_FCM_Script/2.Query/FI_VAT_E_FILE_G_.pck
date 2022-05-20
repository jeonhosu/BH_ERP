CREATE OR REPLACE PACKAGE FI_VAT_E_FILE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_E_FILE_G
Description  : 전자신고파일생성 Package

Reference by : calling assmbly-program id(호출 프로그램) : 전자신고파일생성
Program History :
    -.부가가치세 관련 모든 자료들을 생성(부가세신고서 까지) 후 작업한다. 작업순서상 제일 마지막에 한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-10   Leem Dong Ern(임동언)
*****************************************************************************/


--전역변수
g_SOB_ID            FI_VAT_E_FILE.SOB_ID%TYPE;              --회사아이디
g_ORG_ID            FI_VAT_E_FILE.ORG_ID%TYPE;              --사업부아이디
g_VAT_MNG_SERIAL    FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE;      --부가세신고기간구분번호
g_CREATED_BY        FI_VAT_E_FILE.CREATED_BY%TYPE;          --생성자
g_OPERATING_UNIT_ID FI_VAT_E_FILE.OPERATING_UNIT_ID%TYPE;   --사업장아이디(예>110)
g_REPORT_DOC        FI_VAT_E_FILE.REPORT_DOC%TYPE;          --신고서류명
g_REPORT_CONTENT    FI_VAT_E_FILE.REPORT_CONTENT%TYPE;      --신고내용
g_SPEC_SERIAL       FI_VAT_E_FILE.SPEC_SERIAL%TYPE;         --일련번호

g_SYSDATE           DATE;
g_BUSINESS_ITEM_30  VARCHAR2(100) := NULL;  --업태
g_BUSINESS_TYPE_50  VARCHAR2(100) := NULL;  --종목
g_ATTRIBUTE1        VARCHAR2(100) := NULL;  --업종코드 



--신고서생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_VAT_E_FILE(
      W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE           --회사아이디
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE           --사업부아이디
    , W_OPERATING_UNIT_ID   IN  VARCHAR2                            --사업장아이디(예>110)     
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE   --부가세신고기간구분번호
    --, W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE      --신신고구분(01 : 정기신고)
    , W_CREATE_DATE         IN  DATE    --작성일자
    , W_ISSUE_DATE_FR       IN  DATE    --과세기간_시작
    , W_ISSUE_DATE_TO       IN  DATE    --과세기간_종료     
    , W_CREATED_BY          IN  FI_VAT_E_FILE.CREATED_BY%TYPE       --생성자   
);





--FI_VAT_E_FILE 자료 INSERT
PROCEDURE INSERT_VAT_E_FILE(
      P_REPORT_DOC      IN  FI_VAT_E_FILE.REPORT_DOC%TYPE       --신고서류명
    , P_REPORT_CONTENT  IN  FI_VAT_E_FILE.REPORT_CONTENT%TYPE   --신고내용    
);






--1-3. [부가가치세수입금액등(과세표준명세, 면세수입금액)] 자료 INSERT
PROCEDURE INSERT_1_4(
      W_AMT         IN  NUMBER      --금액
    , W_AMT_KIND    IN  VARCHAR2    --수입금액종류구분  
);








--전자신고 파일 생성에 관련되는 부가세신고서 내역 조회 ; 1번째 텝 조회
PROCEDURE LIST_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
);






--전자신고파일 생성에 필요한 부가세신고서 자료를 수정한다. ; 1번 째 탭 수정
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --회사아이디
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --사업부아이디
    , P_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호    
    
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	        --작성일자
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	        --거래은행
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	    --거래은행코드
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	        --거래지점
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	    --거래지점코드
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	            --계좌번호
    , P_HOMETAX_USERID	    IN	FI_SURTAX_CARD.HOMETAX_USERID%TYPE	    --홈택스_사용자아이디
    , P_VAT_PRESENTER_GB	IN	FI_SURTAX_CARD.VAT_PRESENTER_GB%TYPE    --제출자구분
    , P_VAT_LEVIER_GB	    IN	FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE	    --일반과세자구분
    , P_VAT_REFUND_GB	    IN	FI_SURTAX_CARD.VAT_REFUND_GB%TYPE	    --환급구분
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	        --전자우편주소

    , P_E_FILE_SURTAX_YN	    IN  FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE        --전자신고파일생성대상여부_부가세신고서
    , P_E_FILE_ZERO_YN	        IN  FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE          --전자신고파일생성대상여부_영세율첨부서류제출명세서
    , P_E_FILE_REAL_ESTATE_YN   IN  FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE   --전자신고파일생성대상여부_부동산임대공급가액명세서
    , P_E_FILE_BLD_YN	        IN  FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE           --전자신고파일생성대상여부_건물등감가상각자산취득명세서
    , P_E_FILE_NO_DEDUCTION_YN	IN  FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE  --전자신고파일생성대상여부_공제받지못할매입세액명세서
    , P_E_FILE_SUM_VAT_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE       --전자시고파일생성대상여부_세금계산서합계표
    , P_E_FILE_SUM_CALC_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE      --전자신고파일생성대상여부_계산서합계표
    , P_E_FILE_EXPORT_YN	    IN  FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE        --전자신고파일생성대상여부_수출실적명세서
    , P_E_FILE_GET_YN	        IN  FI_SURTAX_CARD.E_FILE_GET_YN%TYPE           --전자신고파일생성대상여부_신용카드매출전표등수취명세서    
    , P_E_FILE_TAX_PUB_YN	    IN  FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE       --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
    , P_E_FILE_DOMESTIC_LC_YN   IN  FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서
    
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --수정자
);






--전자신고파일 다운로드; 2번째 텝 조회
PROCEDURE FILE_DOWN_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_VAT_E_FILE.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
);




END FI_VAT_E_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_E_FILE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_E_FILE_G
Description  : 전자신고파일생성 Package

Reference by : calling assmbly-program id(호출 프로그램) : 전자신고파일생성
Program History :
    -.부가가치세 관련 모든 자료들을 생성(부가세신고서 까지) 후 작업한다. 작업순서상 제일 마지막에 한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-10   Leem Dong Ern(임동언)
*****************************************************************************/






--신고서생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_VAT_E_FILE(
      W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE           --회사아이디
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE           --사업부아이디
    , W_OPERATING_UNIT_ID   IN  VARCHAR2                            --사업장아이디(예>110)     
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE   --부가세신고기간구분번호
    --, W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE      --신신고구분(01 : 정기신고)
    , W_CREATE_DATE         IN  DATE    --작성일자
    , W_ISSUE_DATE_FR       IN  DATE    --과세기간_시작
    , W_ISSUE_DATE_TO       IN  DATE    --과세기간_종료     
    , W_CREATED_BY          IN  FI_VAT_E_FILE.CREATED_BY%TYPE       --생성자   
)

AS

t_CLOSING_YN        FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부

--공통으로 사용되는 자료를 임시변수에 저장한다.
t_LEGAL_NUMBER      VARCHAR2(100) := NULL;   --주민(법인)등록번호
t_VAT_NUMBER_13     VARCHAR2(100) := NULL;   --사업자등록번호, 길이가 13자리 용
t_VAT_NUMBER_10     VARCHAR2(100) := NULL;   --사업자등록번호, 길이가 10자리 용
t_CORP_NAME_30      VARCHAR2(100) := NULL;   --상호(법인명)
t_PRESIDENT_NAME_30 VARCHAR2(100) := NULL;   --성명(대표자), 길이가 30자리 용
t_PRESIDENT_NAME_15 VARCHAR2(100) := NULL;   --성명(대표자), 길이가 15자리 용
t_LOCATION_70       VARCHAR2(100) := NULL;   --사업장소재지, 길이가 70자리 용
t_LOCATION_45       VARCHAR2(100) := NULL;   --사업장소재지, 길이가 45자리 용
t_REPORT_FR         VARCHAR2(100) := NULL;    --과세기간_시작
t_REPORT_TO         VARCHAR2(100) := NULL;    --과세기간_종료
t_TAX_TERM          VARCHAR2(100) := NULL;    --과세기간_년기
t_REPORT_DEGREE     VARCHAR2(100) := NULL;    --신고차수
t_VAT_TEL           VARCHAR2(100) := NULL;    --전자파일수록용 전화번호
t_ZIP_CODE          VARCHAR2(100) := NULL;    --우편번호
t_TAX_OFFICE_CODE   HRM_OPERATING_UNIT.TAX_OFFICE_CODE%TYPE;    --관할세무서코드


--전자신고대상파일생성대상이 되는 명세서를 파악한다.
t_E_FILE_SURTAX_YN	        FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE;       --전자신고파일생성대상여부_부가세신고서
t_E_FILE_ZERO_YN	        FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE;         --전자신고파일생성대상여부_영세율첨부서류제출명세서
t_E_FILE_REAL_ESTATE_YN	    FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE;  --전자신고파일생성대상여부_부동산임대공급가액명세서
t_E_FILE_BLD_YN	            FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE;          --전자신고파일생성대상여부_건물등감가상각자산취득명세서
t_E_FILE_NO_DEDUCTION_YN	FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE; --전자신고파일생성대상여부_공제받지못할매입세액명세서
t_E_FILE_SUM_VAT_YN	        FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE;      --전자시고파일생성대상여부_세금계산서합계표
t_E_FILE_SUM_CALC_YN	    FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE;     --전자신고파일생성대상여부_계산서합계표
t_E_FILE_EXPORT_YN	        FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE;       --전자신고파일생성대상여부_수출실적명세서
t_E_FILE_GET_YN	            FI_SURTAX_CARD.E_FILE_GET_YN%TYPE;          --전자신고파일생성대상여부_신용카드매출전표등수취명세서
t_E_FILE_TAX_PUB_YN	        FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE;      --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
t_E_FILE_DOMESTIC_LC_YN     FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE;  --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서


t_COL26_3   FI_SURTAX_CARD.COL26_3%TYPE;  --과세표준_금액1
t_COL27_3   FI_SURTAX_CARD.COL27_3%TYPE;  --과세표준_금액2
t_COL28_3   FI_SURTAX_CARD.COL28_3%TYPE;  --과세표준_금액3
t_COL29_3   FI_SURTAX_CARD.COL29_3%TYPE;  --과세표준_금액4
t_COL19_2   FI_SURTAX_CARD.COL19_2%TYPE;  --신용카드매출전표등발행공제등
t_COL18_2   FI_SURTAX_CARD.COL18_2%TYPE;  --기타경감공제세액
t_COL69_3   FI_SURTAX_CARD.COL69_3%TYPE;  --면세사업수입금액_금액1
t_COL70_3   FI_SURTAX_CARD.COL70_3%TYPE;  --면세사업수입금액_금액2
t_COL71_3   FI_SURTAX_CARD.COL71_3%TYPE;  --면세사업수입금액_금액3

--건물등감가상각자산취득명세서 건수, 금액, 합계
t_5_CNT NUMBER(11) := 0;
t_5_AMT NUMBER(13) := 0;
t_5_TAX NUMBER(13) := 0;
t_6_CNT NUMBER(11) := 0;
t_6_AMT NUMBER(13) := 0;
t_6_TAX NUMBER(13) := 0;
t_7_CNT NUMBER(11) := 0;
t_7_AMT NUMBER(13) := 0;
t_7_TAX NUMBER(13) := 0;
t_8_CNT NUMBER(11) := 0;
t_8_AMT NUMBER(13) := 0;
t_8_TAX NUMBER(13) := 0;
t_9_CNT NUMBER(11) := 0;
t_9_AMT NUMBER(13) := 0;
t_9_TAX NUMBER(13) := 0;

--수출실적명세서
t_EXP_SUM_CNT   NUMBER(7) := 0;
t_EXP_SUM_FOR   NUMBER(15,2) := 0.00;
t_EXP_SUM_KOR   NUMBER(15) := 0;
t_EXP_ITEM_CNT  NUMBER(7) := 0;
t_EXP_ITEM_FOR  NUMBER(15,2) := 0.00;
t_EXP_ITEM_KOR  NUMBER(15) := 0;
t_EXP_OTHER_CNT NUMBER(7) := 0;
t_EXP_OTHER_FOR NUMBER(15,2) := 0.00;
t_EXP_OTHER_KOR NUMBER(15) := 0;

t_SEQ           NUMBER(10) := 0;    --[신용카드등 매입내용 합계(Tail Record)] 명세서에서 사용함.

t_CASH_CNT NUMBER := 0;

BEGIN
    --전역변수 값 설정
    g_SYSDATE           := GET_LOCAL_DATE(W_SOB_ID);
    g_SOB_ID            := W_SOB_ID;            --회사아이디
    g_ORG_ID            := W_ORG_ID;            --사업부아이디
    g_VAT_MNG_SERIAL    := W_VAT_MNG_SERIAL;    --부가세신고기간구분번호
    g_CREATED_BY        := W_CREATED_BY;        --생성자
    g_OPERATING_UNIT_ID := W_OPERATING_UNIT_ID; --사업장아이디(예>110)


    --해당 신고기간의 마감여부를 파악한다.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND OPERATING_UNIT_ID = 42                  --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    
    
    --FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_VAT_E_FILE
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND OPERATING_UNIT_ID   = W_OPERATING_UNIT_ID   --사업장아이디
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --부가세신고기간구분번호
        AND VAT_MAKE_GB         = '01'         --신고구분
    ;
    
        
    --공통으로 사용되는 자료를 임시변수에 저장한다.

    SELECT
          RPAD(REPLACE(A.LEGAL_NUMBER, '-', ''), 13, ' ') AS LEGAL_NUMBER   --주민(법인)등록번호('-'제거한것)           
        , RPAD(REPLACE(B.VAT_NUMBER, '-', ''), 13, ' ') AS VAT_NUMBER_13       --사업자등록번호('-'제거한것) 
        , RPAD(REPLACE(B.VAT_NUMBER, '-', ''), 10, ' ') AS VAT_NUMBER_10       --사업자등록번호('-'제거한것) 
        , RPAD(A.CORP_NAME, 30, ' ')        --상호(법인명)      
        , RPAD(A.PRESIDENT_NAME, 30, ' ')   --성명(대표자)
        , RPAD(A.PRESIDENT_NAME, 15, ' ')   --성명(대표자)
        , RPAD(B.ADDR1 || ' ' || B.ADDR2, 70, ' ')  --사업장소재지
        , RPAD(B.ADDR1 || ' ' || B.ADDR2, 45, ' ')  --사업장소재지
        , RPAD(B.BUSINESS_ITEM, 30, ' ')    --업태       
        , RPAD(B.BUSINESS_TYPE, 50, ' ')    --종목         
        , RPAD(B.ATTRIBUTE1, 7, ' ')        --업종코드     
        , TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD') AS REPORT_FR    --신고기간_시작
        , TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD') AS REPORT_TO    --신고기간_종료 
        , TO_CHAR(W_ISSUE_DATE_TO, 'YYYY') || 
            CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '06' THEN '01'
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '12' THEN '02'
            END AS TAX_TERM -- 과세기간_년기
        , LPAD(CASE 
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
          END, 4, '0') AS REPORT_DEGREE   -- 신고차수
        , RPAD(A.ATTRIBUTE1, 4, ' ') || RPAD(A.ATTRIBUTE2, 4, ' ') || RPAD(A.ATTRIBUTE3, 7, ' ') AS VAT_TEL --전자파일수록용 전화번호
        , B.ZIP_CODE                        --우편번호
        , RPAD(B.TAX_OFFICE_CODE, 3, ' ')   --관할세무서코드
        --, A.TEL_NUMBER                          --전화번호
        --, B.TAX_OFFICE_NAME --관할세무서        
    INTO
          t_LEGAL_NUMBER        --주민(법인)등록번호          
        , t_VAT_NUMBER_13       --사업자등록번호
        , t_VAT_NUMBER_10       --사업자등록번호        
        , t_CORP_NAME_30        --상호(법인명)        
        , t_PRESIDENT_NAME_30   --성명(대표자)
        , t_PRESIDENT_NAME_15   --성명(대표자) 
        , t_LOCATION_70         --사업장소재지 
        , t_LOCATION_45         --사업장소재지
        , g_BUSINESS_ITEM_30    --업태         
        , g_BUSINESS_TYPE_50    --종목
        , g_ATTRIBUTE1          --업종코드 
        , t_REPORT_FR           --과세기간_시작
        , t_REPORT_TO           --과세기간_종료
        , t_TAX_TERM            --과세기간_년기
        , t_REPORT_DEGREE       --신고차수
        , t_VAT_TEL             --전자파일수록용 전화번호
        , t_ZIP_CODE            --우편번호
        , t_TAX_OFFICE_CODE     --관할세무서코드
    FROM HRM_CORP_MASTER A, HRM_OPERATING_UNIT B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.CORP_ID = 65  --법인아이디
        AND A.CORP_ID = B.CORP_ID
        AND B.OPERATING_UNIT_ID = 42   ;     
    
    
    
    
    
    
    --전자신고대상파일생성대상이 되는 명세서를 파악한다.
    --파악한 결과에 따라 생성대상인 명세서만을 전자신고파일로 생성하기 위함이다.
    SELECT
          E_FILE_SURTAX_YN          --전자신고파일생성대상여부_부가세신고서
        , E_FILE_ZERO_YN            --전자신고파일생성대상여부_영세율첨부서류제출명세서
        , E_FILE_REAL_ESTATE_YN     --전자신고파일생성대상여부_부동산임대공급가액명세서
        , E_FILE_BLD_YN             --전자신고파일생성대상여부_건물등감가상각자산취득명세서
        , E_FILE_NO_DEDUCTION_YN    --전자신고파일생성대상여부_공제받지못할매입세액명세서
        , E_FILE_SUM_VAT_YN         --전자시고파일생성대상여부_세금계산서합계표
        , E_FILE_SUM_CALC_YN        --전자신고파일생성대상여부_계산서합계표
        , E_FILE_EXPORT_YN          --전자신고파일생성대상여부_수출실적명세서
        , E_FILE_GET_YN             --전자신고파일생성대상여부_신용카드매출전표등수취명세서
        , E_FILE_TAX_PUB_YN         --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
        , E_FILE_DOMESTIC_LC_YN     --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서         
    INTO
          t_E_FILE_SURTAX_YN        --전자신고파일생성대상여부_부가세신고서
        , t_E_FILE_ZERO_YN          --전자신고파일생성대상여부_영세율첨부서류제출명세서
        , t_E_FILE_REAL_ESTATE_YN   --전자신고파일생성대상여부_부동산임대공급가액명세서
        , t_E_FILE_BLD_YN           --전자신고파일생성대상여부_건물등감가상각자산취득명세서
        , t_E_FILE_NO_DEDUCTION_YN  --전자신고파일생성대상여부_공제받지못할매입세액명세서
        , t_E_FILE_SUM_VAT_YN       --전자시고파일생성대상여부_세금계산서합계표
        , t_E_FILE_SUM_CALC_YN      --전자신고파일생성대상여부_계산서합계표
        , t_E_FILE_EXPORT_YN        --전자신고파일생성대상여부_수출실적명세서
        , t_E_FILE_GET_YN           --전자신고파일생성대상여부_신용카드매출전표등수취명세서        
        , t_E_FILE_TAX_PUB_YN       --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
        , t_E_FILE_DOMESTIC_LC_YN   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서        
    FROM FI_SURTAX_CARD    
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND OPERATING_UNIT_ID   = W_OPERATING_UNIT_ID   --사업장아이디
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --부가세신고기간구분번호
        AND VAT_MAKE_GB         = '01'         --신고구분(01 : 정기신고)
    ;



--1.부가가치세 일반 및 간이 신고서
IF t_E_FILE_SURTAX_YN = 'Y' THEN          --전자신고파일생성대상여부_부가세신고서

    --1-1. [신고서 HEAD 레코드]의 신고내용 생성
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;
    
    SELECT
        
           '11'             --1.자료구분 	    CHAR	2 [부가가치세 일반 ’11’, 간이 ‘12’ ]        
        || 'V101'           --2.서식코드	    CHAR	4 [일반사업자는 ‘V101', 간이사업자는 'V102' ]        
        ||  t_VAT_NUMBER_13    --3.납세자ID	    CHAR	13 [사업자등록번호]        
        || '41'             --4.세목구분코드	CHAR	2   [‘41’ 부가가치세]        
        || CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '3'  --예정신고
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '1'  --확정신고
           END                      --5.신고구분	        CHAR	1        
        || '8'                      --6.납세자구분	        CHAR	1   [ ‘1’ 개인, ‘8’ 법인]        
        || t_TAX_TERM               --7.과세기간_년기(월)	CHAR	6
        || t_REPORT_DEGREE          --8.신고차수	        NUMBER	4
        || LPAD(1, 4, 0)            --9.순차번호	        NUMBER	4   [] ‘1’ 정기신고?기한후신고,  ‘2이상’ 수정신고 ?경정청구 
        || RPAD('bhflex', 20, ' ')  --10.사용자ID	        CHAR	20  [홈택스시스템에 등록된 사용자(개인 또는 세무대리인)의 ID]
        || t_LEGAL_NUMBER           --11.납세자번호	        CHAR	13      Null 허용 [법인등록번호]
        || RPAD(' ', 30, ' ')       --12.세무대리인성명	    CHAR	30  Null 허용
        || RPAD(' ', 6, ' ')        --13.세무대리인관리번호	CHAR	6	106	space
        || RPAD(' ', 4, ' ')        --14.세무대리인전화번호1(지역번호)	CHAR	4	Null 허용
        || RPAD(' ', 5, ' ')        --15.세무대리인전화번호2(국번)	    CHAR	5	Null 허용
        || RPAD(' ', 5, ' ')        --16.세무대리인전화번호3(지역번호,국번을제외한번호)	CHAR	5	Null 허용
        || t_CORP_NAME_30           --17.상호(법인명)	CHAR	30
        || t_PRESIDENT_NAME_30      --18.성명(대표자명)	CHAR	30
        || t_LOCATION_70            --19.사업장소재지	CHAR	70	Null 허용
        || RPAD(' ', 14, ' ')       --20.사업장전화번호	CHAR	14	Null 허용
        || t_LOCATION_70            --21.사업자주소	    CHAR	70	Null 허용
        || RPAD(' ', 14, ' ')       --22.사업자전화번호	CHAR	14	Null 허용
        || g_BUSINESS_ITEM_30       --23.업태명	        CHAR	30
        || g_BUSINESS_TYPE_50       --24.종목명	        CHAR	50
        || g_ATTRIBUTE1             --25.업종코드	    CHAR	7
        || t_REPORT_FR              --26.과세기간(시작일)	    CHAR	8
        || t_REPORT_TO              --27.과세기간(종료일)	    CHAR	8
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')   --28.작성일자	CHAR	8
        || '19990501'           --29.개업년월일	            CHAR	8
        || 'N'                  --30.보정신고구분	        CHAR	1   [‘N’ : 정상 , ‘Y’ : 보정]
        || RPAD(' ', 14, ' ')   --31.사업자휴대전화	        CHAR	14	Null 허용
        || '9000'               --32.세무프로그램코드	    CHAR	4   [9000 : 기타]
        || RPAD(' ', 10, ' ')   --33.세무대리인사업자번호	CHAR	10	Null 허용
        || RPAD(' ', 50, ' ')   --34.전자메일주소	        CHAR	50	Null 허용
        || '100'                --35.신고종류구분코드	    CHAR	3   [100 : 일반신고서 정기신고,간이신고서 정기신고]
        || RPAD(' ', 51, ' ')   --36.공란	                CHAR	51
    INTO g_REPORT_CONTENT
    FROM DUAL;
    

    --1-1. 신고서 HEAD 레코드
    --서식명 : 부가가치세(일반,간이 공통), File : 부가가치세_헤더, 길이 : 600
    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , VAT_MAKE_GB	    --신고구분
        , SPEC_SERIAL	    --일련번호

        , REPORT_DOC        --신고서류명
        , REPORT_CONTENT    --신고내용
        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_OPERATING_UNIT_ID       --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , '01'	                    --신고구분
        , g_SPEC_SERIAL             --일련번호 

        , '신고서 HEAD 레코드'      --신고서류명
        , g_REPORT_CONTENT          --신고내용
        
        , g_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , g_SYSDATE     --수정일
        , W_CREATED_BY  --수정자         
    FROM DUAL   ;
    
    
    
    --1-2. [일반신고서 레코드]의 신고내용 생성
    --부가세신고서의 각 내용을 담는다.
    
    g_REPORT_CONTENT := NULL;
        
    SELECT
           '17'      --1.자료구분    CHAR	2   [부가가치세_일반의 Data 시작부분 ‘17’]
        || 'V101'    --2.서식코드    CHAR	4
        || LPAD(REPLACE(LPAD(NVL(COL1_1, 0), 15, 0), '-', ''), 15, '-')	    --3.과표신고과세세금계산서금액	(1)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL1_2, 0), 13, 0), '-', ''), 13, '-')	    --4.과표신고과세세금계산서세액	(1)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL4_1, 0), 13, 0), '-', ''), 13, '-')	    --5.과표신고과세기타금액	    (4)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL4_2, 0), 13, 0), '-', ''), 13, '-')	    --6.과표신고과세기타세액	    (4)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL5_1, 0), 13, 0), '-', ''), 13, '-')	    --7.과표신고영세세금계산서금액	(5)	    NUMBER	13
        
        || LPAD(REPLACE(LPAD(NVL(COL6_1, 0), 15, 0), '-', ''), 15, '-')     --8.과표신고영세기타금액	    (6)	    NUMBER	15
        
        || LPAD(REPLACE(LPAD(NVL(COL31_1, 0), 13, 0), '-', ''), 13, '-')    --9.과표예정과세세금계산서금액	(31)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL31_2, 0), 13, 0), '-', ''), 13, '-')	--10.과표예정과세세금계산서세액	(31)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL32_1, 0), 13, 0), '-', ''), 13, '-')	--11.과표예정과세기타금액	    (32)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL32_2, 0), 13, 0), '-', ''), 13, '-')	--12.과표예정과세기타세액	    (32)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL33_1, 0), 13, 0), '-', ''), 13, '-')	--13.과표예정영세세금계산서금액	(33)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL34_1, 0), 13, 0), '-', ''), 13, '-')	--14.과표예정영세기타금액	    (34)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL8_2, 0), 13, 0), '-', ''), 13, '-')	    --15.대손세액가감세액	        (8)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL10_1, 0), 15, 0), '-', ''), 15, '-')	--16.매입수취일반금액	        (10)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL10_2, 0), 13, 0), '-', ''), 13, '-')	--17.매입수취일반세액	        (10)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL11_1, 0), 13, 0), '-', ''), 13, '-')	--18.매입수취고정자산금액	    (11)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL11_2, 0), 13, 0), '-', ''), 13, '-')	--19.매입수취고정자산세액	    (11)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL39_1, 0), 13, 0), '-', ''), 13, '-')	--20.매입금전신용금액	        (39)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL39_2, 0), 13, 0), '-', ''), 13, '-')	--21.매입금전신용세액	        (39)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL41_1, 0), 13, 0), '-', ''), 13, '-')	--22.매입의제매입금액	        (41)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL41_2, 0), 13, 0), '-', ''), 13, '-')	--23.매입의제매입세액	        (41)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL42_1, 0), 13, 0), '-', ''), 13, '-')	--24.매입재활용금액	            (42)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL42_2, 0), 13, 0), '-', ''), 13, '-')	--25.매입재활용세액	            (42)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL45_2, 0), 13, 0), '-', ''), 13, '-')	--26.매입재고매입세액	        (45)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL46_2, 0), 13, 0), '-', ''), 13, '-')	--27.매입변제대손세액	        (46)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL15_1, 0), 15, 0), '-', ''), 15, '-')	--28.매입금액합계	            (15)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL15_2, 0), 13, 0), '-', ''), 13, '-')	--29.매입세액합계	            (15)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL49_1, 0), 13, 0), '-', ''), 13, '-')	--30.공통매입면세사업금액	    (49)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL49_2, 0), 13, 0), '-', ''), 13, '-')	--31.공통매입면세사업세액	    (49)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL48_1, 0), 13, 0), '-', ''), 13, '-')	--32.불공제매입금액	            (48)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL48_2, 0), 13, 0), '-', ''), 13, '-')	--33.불공제매입세액	            (48)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL50_2, 0), 13, 0), '-', ''), 13, '-')	--34.대손처분세액	            (50)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL17_1, 0), 15, 0), '-', ''), 15, '-')	--35.차감매입금액	            (17)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL17_2, 0), 13, 0), '-', ''), 13, '-')	--36.차감매입세액	            (나)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL_DA, 0), 13, 0), '-', ''), 13, '-')	    --37.납부(환급)세액	            (다)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL58_1, 0), 13, 0), '-', ''), 13, '-')	--38.사업자등록가산금액	        (58)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL58_2, 0), 13, 0), '-', ''), 13, '-')	--39.사업자등록가산세	        (58)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL63_1, 0), 13, 0), '-', ''), 13, '-')	--40.세금계산서합계표가산금액	(63)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL63_2, 0), 13, 0), '-', ''), 13, '-')	--41.세금계산서합계표가산세	    (63)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL64_1, 0), 13, 0), '-', ''), 13, '-')	--42.신고불성실가산금액	        (64)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL64_2, 0), 13, 0), '-', ''), 13, '-')	--43.신고불성실가산세액	        (64)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL66_1, 0), 13, 0), '-', ''), 13, '-')	--44.영세율신고가산금액	        (66)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL66_2, 0), 13, 0), '-', ''), 13, '-')	--45.영세율신고가산세	        (66)	NUMBER	13
        || LPAD(0, 13, 0)                                                   --46.금전신용공제금액	        (19)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL19_2, 0), 13, 0), '-', ''), 13, '-')	--47.금전신용공제세액	        (19)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL22_2, 0), 13, 0), '-', ''), 13, '-')	--48.예정고지세액	            (바)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL21_2, 0), 13, 0), '-', ''), 13, '-')	--49.예정미환급세액	            (마)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL30, 0), 15, 0), '-', ''), 15, '-')	    --50.과세수입금액합계	        (30)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL29_3, 0), 13, 0), '-', ''), 13, '-')	--51.과세수입금액제외금액	    (29)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL72, 0), 15, 0), '-', ''), 15, '-')	    --52.면세수입금액합계	        (72)	NUMBER	    15
        || NVL(VAT_REFUND_GB, ' ')                                          --53.환급구분 CHAR	1   Null 허용  
        || LPAD(REPLACE(LPAD(NVL(COL54_2, 0), 13, 0), '-', ''), 13, '-')	--54.택시사업자부가가치세경감세액	(54)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL7_1, 0), 13, 0), '-', ''), 13, '-')	    --55.과표예정신고누락분금액	        (7)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL7_2, 0), 13, 0), '-', ''), 13, '-')	    --56.과표예정신고누락분세액	        (7)	    NUMBER	13
        || LPAD(0, 13, 0)                                                   --57.대손세액가감금액	            (8)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL14_1, 0), 13, 0), '-', ''), 13, '-')	--58.매입기타공제금액	            (14)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL14_2, 0), 13, 0), '-', ''), 13, '-')	--59.매입기타공제세액	            (14)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL16_1, 0), 13, 0), '-', ''), 13, '-')	--60.매입공제받지못할금액	        (16)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL16_2, 0), 13, 0), '-', ''), 13, '-')	--61.매입공제받지못할세액	        (16)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL24_2, 0), 13, 0), '-', ''), 13, '-')	--62.가산세계	                    (아)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL35_1, 0), 13, 0), '-', ''), 13, '-')	--63.과표예정신고누락분금액합계	    (35)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL35_2, 0), 13, 0), '-', ''), 13, '-')	--64.과표예정신고누락분세액합계	    (35)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL47_1, 0), 13, 0), '-', ''), 13, '-')	--65.기타공제매입금액합계	        (47)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL47_2, 0), 13, 0), '-', ''), 13, '-')	--66.기타공제매입세액합계	        (47)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL50_1, 0), 13, 0), '-', ''), 13, '-')	--67.대손처분금액	                (50)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL51_1, 0), 13, 0), '-', ''), 13, '-')	--68.매입공제받지못할금액합계	    (51)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL51_2, 0), 13, 0), '-', ''), 13, '-')	--69.매입공제받지못할세액합계	    (51)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL68_2, 0), 13, 0), '-', ''), 13, '-')	--70.가산세세액계	                (68)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL20_2, 0), 13, 0), '-', ''), 13, '-')	--71.경감세액계	                    (라)	NUMBER	13
        || LPAD(0, 13, 0)    --72.성실신고사업자경감세액             NUMBER  13
        || LPAD(0, 13, 0)    --73.POS도입 사업자등에 대한 경감세액   NUMBER  13
        || LPAD(REPLACE(LPAD(NVL(COL65_1, 0), 13, 0), '-', ''), 13, '-')	--74.납부불성실가산금액	        (65)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL65_2, 0), 13, 0), '-', ''), 13, '-')	--75.납부불성실가산세액	        (65)	NUMBER	13
        || LPAD(0, 15, 0)    --76.일반과세전환자 공제세액            NUMBER      15
        || LPAD(REPLACE(LPAD(NVL(COL18_2, 0), 15, 0), '-', ''), 15, '-')	--77.기타공제_경감세액	        (18)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL9_1, 0), 15, 0), '-', ''), 15, '-')	    --78.과세표준	                (9)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL25, 0), 15, 0), '-', ''), 15, '-')      --79.차감납부할세액	            (25)	NUMBER	    15
        
        --은행코드와 계좌번호가 모두 있거나 모두 없으면 정상, 하나만 존재하는 경우 에러처리함
        || (
            SELECT RPAD(NVL(CODE, ' '), 3, ' ')
            FROM FI_COMMON 
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND GROUP_CODE = 'VAT_BANK_CODE'
                AND VALUE1 = DEAL_BANK_CD    
          ) --80.은행코드(국세환급금)  CHAR	3   Null 허용
        || RPAD(REPLACE(NVL(ACC_NO, ' '), '-', ''), 20, ' ')         --81.계좌번호(국세환급금)    CHAR	20  Null 허용
        
        || RPAD(' ', 7, ' ')                                         --82.총괄납부승인번호        CHAR	7   Null 허용
        || RPAD(NVL(DEAL_BRANCH, ' '), 30, ' ')                      --83.은행지점명              CHAR	30  Null 허용
        || LPAD(REPLACE(LPAD(COL9_2, 15, 0), '-', ''), 15, '-')      --84.산출세액	(가)	      NUMBER	15
        || RPAD(NVL(TO_CHAR(CLOSURE_DATE, 'YYYYMMDD'), ' '), 8, ' ') --85.폐업일자                CHAR	8   Null 허용
        || RPAD(NVL(CLOSURE_REASON, ' '), 3, ' ')                    --86.폐업사유                CHAR	3   Null 허용    
        || 'N'   --87.기한후(과세표준)여부  CHAR	1   Not Null    [정기신고  :  N, 기한후신고 : Y]
        || LPAD(REPLACE(LPAD(NVL(COL73, 0), 15, 0), '-', ''), 15, '-')	    --88.계산서 발급금액	            (73)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL74, 0), 15, 0), '-', ''), 15, '-')	    --89.계산서 수취금액	            (74)	NUMBER	    15    
        || LPAD(REPLACE(LPAD(NVL(COL12_1, 0), 13, 0), '-', ''), 13, '-')    --90.매입예정신고누락금액	        (12)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL12_2, 0), 13, 0), '-', ''), 13, '-')	--91.매입예정신고누락세액	        (12)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL36_1, 0), 13, 0), '-', ''), 13, '-')	--92.예정매입세금계산서누락금액	    (36)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL36_2, 0), 13, 0), '-', ''), 13, '-')	--93.예정매입세금계산서누락세액	    (36)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL37_1, 0), 13, 0), '-', ''), 13, '-')	--94.예정매입기타공제누락세액금액	(37)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL37_2, 0), 13, 0), '-', ''), 13, '-')	--95.예정매입기타공제누락세액세액	(37)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL38_1, 0), 13, 0), '-', ''), 13, '-')	--96.예정매입누락합계금액	        (38)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL38_2, 0), 13, 0), '-', ''), 13, '-')	--97.예정매입누락합계세액	        (38)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL56_2, 0), 13, 0), '-', ''), 13, '-')	--98.기타경감공제세액명세기타세액	(56)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL52_2, 0), 13, 0), '-', ''), 13, '-')	--99.전자신고공제세액	            (52)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL55_2, 0), 13, 0), '-', ''), 13, '-')	--100.현금영수증사업자공제세액	    (55)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL25, 0), 15, 0), '-', ''), 15, '-')      --101.실차감납부할세액                      NUMBER      15    [차가감하여납부할세액]
        || NVL(VAT_LEVIER_GB, '0')   --102.일반과세자구분 CHAR    1 Not Null    [0 : 사업자단위신고?납부자가 아닌 일반 사업자]
        || '0'                       --103.조기환급취소구분    CHAR    1   [1:조기환급취소, 0:기본값]
        || LPAD(REPLACE(LPAD(NVL(COL44_2, 0), 13, 0), '-', ''), 13, '-')	--104.과세사업전환매입세액	            (44)	NUMBER	13 
        || LPAD(REPLACE(LPAD(NVL(COL67_1, 0), 13, 0), '-', ''), 13, '-')	--105.현금매출명세서미제출등가산금액	(67)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL67_2, 0), 13, 0), '-', ''), 13, '-')	--106.현금매출명세서미제출등가산세액	(67)	NUMBER	13    
        || LPAD(REPLACE(LPAD(NVL(COL2_1, 0), 13, 0), '-', ''), 13, '-')	    --107.과표신고과세매입자발행금액	    (2)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL2_2, 0), 13, 0), '-', ''), 13, '-')	    --108.과표신고과세매입자발행세액	    (2)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL13_1, 0), 13, 0), '-', ''), 13, '-')	--109.매입매입자발행금액	            (13)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL13_2, 0), 13, 0), '-', ''), 13, '-')	--110.매입매입자발행세액	            (13)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL23_2, 0), 13, 0), '-', ''), 13, '-')	--111.금지금매입자납부특례기납부세액	(사)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL43_1, 0), 13, 0), '-', ''), 13, '-')	--112.매입고금의제매입금액	            (43)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL43_2, 0), 13, 0), '-', ''), 13, '-')	--113.매입고금의제매입세액	            (43)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL60_1, 0), 13, 0), '-', ''), 13, '-')	--114.세금계산서미발급등가산금액	    (60)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL60_2, 0), 13, 0), '-', ''), 13, '-')	--115.세금계산서미발급등가산세액	    (60)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL3_1, 0), 15, 0), '-', ''), 15, '-')	    --116.과표신고신용카드현금영수증금액	(3)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL3_2, 0), 15, 0), '-', ''), 15, '-')	    --117.과표신고신용카드현금영수증세액	(3)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL40_1, 0), 15, 0), '-', ''), 15, '-')	--118.매입신용고정자산금액	            (40)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL40_2, 0), 15, 0), '-', ''), 15, '-')	--119.매입신용고정자산세액	            (40)	NUMBER	    15       
        || LPAD(REPLACE(LPAD(NVL(COL53_2, 0), 13, 0), '-', ''), 13, '-')	--120.전자세금계산서발급세액공제세액	(53)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL61_1, 0), 13, 0), '-', ''), 13, '-')	--121.전자세금계산서발급명세전송가산금액_다음달15일후	        (61)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL61_2, 0), 13, 0), '-', ''), 13, '-')	--122.전자세금계산서발급명세전송가산세액_다음달15일후	        (61)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL71_3, 0), 13, 0), '-', ''), 13, '-')	--123.면세수입금액제외금액	                                    (71)	NUMBER	13   
        || LPAD(REPLACE(LPAD(NVL(COL62_1, 0), 13, 0), '-', ''), 13, '-')	--124.전자세금계산서발급명세전송가산금액_과세기간다음달15일후	(62)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL62_2, 0), 13, 0), '-', ''), 13, '-')	--125.전자세금계산서발급명세전송가산세액_과세기간다음달15일후	(62)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL59_1, 0), 13, 0), '-', ''), 13, '-')	--126.세금계산서지연발급등가산금액	(59)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL59_2, 0), 13, 0), '-', ''), 13, '-')	--127.세금계산서지연발급등가산세액	(59)	NUMBER	13
        -- <2012년1기예정 추가>
        || LPAD(REPLACE(LPAD(NVL(R_ORIGIN_PLACE_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 128.원산지확인서발급세액공제.
        || LPAD(REPLACE(LPAD(NVL(A_TAX_RECEIVE_DELAY_AMT, 0), 13, '0'), '-', ''), 13, '-')  -- 129.세금계산서지연수취가산금액.
        || LPAD(REPLACE(LPAD(NVL(A_TAX_RECEIVE_DELAY_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 130.세금계산서지연수취가산세액.
        || RPAD(' ', 47, ' ')    --128.공란  CHAR    47
    INTO g_REPORT_CONTENT
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01' --신고구분(01 : 정기신고)
    ;


    --1-2. 일반신고서 레코드
    --서식명 : 일반과세자 부가가치세 신고서, File : 부가가치세_일반, 길이 : 1700
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , VAT_MAKE_GB	    --신고구분
        , SPEC_SERIAL	    --일련번호

        , REPORT_DOC        --신고서류명
        , REPORT_CONTENT    --신고내용
        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_OPERATING_UNIT_ID       --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , '01'	                    --신고구분
        , g_SPEC_SERIAL             --일련번호 

        , '일반신고서 레코드'       --신고서류명
        , g_REPORT_CONTENT          --신고내용
        
        , g_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , g_SYSDATE     --수정일
        , W_CREATED_BY  --수정자         
    FROM DUAL   ;



    --1-3. [부가가치세수입금액등(과세표준명세, 면세수입금액)]의 신고내용 생성
    --부가가치세신고서(일반,간이)의 “과세표준명세”,”면세수입금액”의 입력항목들입니다.    

    SELECT
          COL26_3 --과세표준_금액1    ; 수입금액종류구분  : 1
        , COL27_3 --과세표준_금액2    ; 수입금액종류구분  : 1
        , COL28_3 --과세표준_금액3    ; 수입금액종류구분  : 1
        , COL29_3 --과세표준_금액4    ; 수입금액종류구분  : 2
        
        , COL19_2 --신용카드매출전표등발행공제등    ; 수입금액종류구분  : 4
        , COL18_2 --기타경감공제세액    ; 수입금액종류구분  : 7
        
        , COL69_3 --면세사업수입금액_금액1    ; 수입금액종류구분  : 8
        , COL70_3 --면세사업수입금액_금액2    ; 수입금액종류구분  : 8
        , COL71_3 --면세사업수입금액_금액3    ; 수입금액종류구분  : E
    INTO t_COL26_3, t_COL27_3, t_COL28_3, t_COL29_3, t_COL19_2, t_COL18_2, t_COL69_3, t_COL70_3, t_COL71_3  
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01' --신고구분(01 : 정기신고)
    ;    
    
    
    IF t_COL26_3 IS NOT NULL THEN
        INSERT_1_4(t_COL26_3, '1');
    END IF;
    
    IF t_COL27_3 IS NOT NULL THEN
        INSERT_1_4(t_COL27_3, '1');
    END IF;

    IF t_COL28_3 IS NOT NULL THEN
        INSERT_1_4(t_COL28_3, '1');
    END IF;

    IF t_COL29_3 IS NOT NULL THEN
        INSERT_1_4(t_COL29_3, '2');
    END IF;

    IF t_COL19_2 IS NOT NULL THEN
        INSERT_1_4(t_COL19_2, '4');
    END IF;

    IF t_COL18_2 IS NOT NULL THEN
        INSERT_1_4(t_COL18_2, '7');
    END IF;

    IF t_COL69_3 IS NOT NULL THEN
        INSERT_1_4(t_COL69_3, '8');
    END IF;

    IF t_COL70_3 IS NOT NULL THEN
        INSERT_1_4(t_COL70_3, '8');
    END IF;

    IF t_COL71_3 IS NOT NULL THEN
        INSERT_1_4(t_COL71_3, 'E');
    END IF;    

END IF; --IF t_E_FILE_SURTAX_YN = 'Y' THEN          --전자신고파일생성대상여부_부가세신고서




--2.첨부서류

IF t_E_FILE_ZERO_YN = 'Y' THEN          --전자신고파일생성대상여부_영세율첨부서류제출명세서

    --2-3.영세율첨부서류제출명세서
    --서식명 : 영세율첨부서류제출명세서 , File : 영세율첨부서류제출명세서, 길이 : 250
    
    FOR REC_2_3 IN (
        SELECT
               '17'                  --1.자료구분		 CHAR	2
            || 'V106'                --2.서식코드        CHAR	4 
            || ZERO_TAX_RATE_REASON  --3.제출사유코드    CHAR	2            
            || RPAD(FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', ZERO_TAX_RATE_REASON, SOB_ID, ORG_ID), 60, ' ') --4.제출사유    CHAR    60
            || LPAD(ROWNUM, 6, 0)        --5.일련번호    (9)     CHAR	6    
            || RPAD(DOC_NAME, 40, ' ')   --6.서류명	    (10)	CHAR	40
            || RPAD(PUBLISHER, 20, ' ')  --7.발급자	    (11)	CHAR	20       
            || TO_CHAR(PUBLISH_DATE, 'YYYYMMDD')    --8.발급일자	(12)	CHAR	8
            || TO_CHAR(SHIPPING_DATE, 'YYYYMMDD')   --9.선적일자	(13)	CHAR	8
            || CURRENCY_CODE             --10.수출통화코드	(14)	CHAR	3    
            || LPAD(REPLACE(TO_CHAR(NVL(EXCHANGE_RATE, 0), 'FM99999.0000'), '.', ''), 9, 0)              --11.환율	(15)	NUMBER	9,4    
            || LPAD(REPLACE(TO_CHAR(NVL(SUBMIT_FOREIGN_AMT, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --12.당기제출금액(외화)	(16)	NUMBER	15,2
            || LPAD(NVL(SUBMIT_KOREAN_AMT, 0), 15, 0)                                                    --13.당기제출금액(원화)	(17)	NUMBER	15    
            || LPAD(REPLACE(TO_CHAR(NVL(REPORT_FOREIGN_AMT, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --14,당기신고해당분(외화)	(18)	NUMBER	15,2
            || LPAD(NVL(REPORT_KOREAN_AMT, 0), 15, 0)                                                    --15.당기신고해당분(원화)	(19)	NUMBER	15
            || RPAD(' ', 28, ' ')    --16.공란		CHAR	28
            AS REC
        FROM
            (
                SELECT 
                      SOB_ID            --회사아이디
                    , ORG_ID            --사업부아이디
                    , OPERATING_UNIT_ID --사업장아이디
                    , VAT_MNG_SERIAL    --부가세신고기간구분번호
                    , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --신고기간구분명
                    , ZERO_TAX_RATE_REASON  --제출사유
                    , SPEC_SERIAL           --일련번호
                    , DOC_NAME              --서류명
                    , PUBLISHER             --발급자
                    , PUBLISH_DATE          --발급일자
                    , SHIPPING_DATE         --선적일자        
                    , CURRENCY_CODE         --통화
                    , EXCHANGE_RATE         --환율
                    , SUBMIT_FOREIGN_AMT    --당기제출외화
                    , SUBMIT_KOREAN_AMT     --당기제출원화
                    , REPORT_FOREIGN_AMT    --당기신고외화
                    , REPORT_KOREAN_AMT     --당기신고원화
                FROM FI_ZERO_TAX_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND OPERATING_UNIT_ID = 42
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                ORDER BY PUBLISH_DATE, SHIPPING_DATE    
            ) T
    ) LOOP
            
        SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

        INSERT INTO FI_VAT_E_FILE(
              SOB_ID	        --회사아이디
            , ORG_ID	        --사업부아이디        
            , OPERATING_UNIT_ID	--사업장아이디
            , VAT_MNG_SERIAL	--부가세신고기간구분번호
            , VAT_MAKE_GB	    --신고구분
            , SPEC_SERIAL	    --일련번호

            , REPORT_DOC        --신고서류명
            , REPORT_CONTENT    --신고내용
            
            , CREATION_DATE     --생성일
            , CREATED_BY	    --생성자
            , LAST_UPDATE_DATE  --수정일
            , LAST_UPDATED_BY	--수정자          
        )
        SELECT
              W_SOB_ID  --회사아이디
            , W_ORG_ID  --사업부아이디
            , W_OPERATING_UNIT_ID       --사업장아이디
            , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
            , '01'	                    --신고구분
            , g_SPEC_SERIAL             --일련번호 

            , '영세율첨부서류제출명세서'    --신고서류명
            , REC_2_3.REC                   --신고내용
            
            , g_SYSDATE     --생성일
            , W_CREATED_BY  --생성자
            , g_SYSDATE     --수정일
            , W_CREATED_BY  --수정자         
        FROM DUAL   ;

    END LOOP REC_2_3;

END IF;    --IF t_E_FILE_ZERO_YN = 'Y' THEN          --전자신고파일생성대상여부_영세율첨부서류제출명세서




IF t_E_FILE_REAL_ESTATE_YN = 'Y' THEN   --전자신고파일생성대상여부_부동산임대공급가액명세서

    --2-7.부동산임대공급가액명세서
    --서식명 : 부동산임대공급가액명세서 , File : 부동산임대공급가액명세서, 길이 : 250
    
    g_REPORT_CONTENT := NULL;
    
    SELECT
           '17'                 --1.자료구분		CHAR	2
        || 'V120'               --2.서식코드        CHAR	4 
        || '000001'             --3.일련번호구분	CHAR	6   [?	사업자단위과세적용사업장이 아닌 경우 ‘000001’를 기재]
        || RPAD(' ', 70, ' ')   --4.부동산소재지	CHAR	70  Null 허용
        || LPAD(NVL(DEPOSIT, 0), 15, 0)     --5.임대계약내용보증금합계	    NUMBER	15
        || LPAD(NVL(MONTH_RENT, 0), 15, 0)  --6.임대계약내용월세등합계	    NUMBER	15
        || LPAD(NVL(RENT_SUM, 0), 15, 0)    --7.임대료수입금액합계	        NUMBER	15
        || LPAD(NVL(DEEMED_RENT, 0), 15, 0) --8.임대료수입보증금이자합계	NUMBER	15
        || LPAD(NVL(TAX_MM_FEE, 0), 15, 0)  --9.임대료수입월세등합계	    NUMBER	15
        || t_VAT_NUMBER_10                  --10.임대인사업자등록번호	    CHAR	10
        || LPAD((SELECT COUNT(*)
                FROM FI_BLD_AMT_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND OPERATING_UNIT_ID = 42
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL)
           , 6, 0) --11.임대건수	NUMBER	6
        || '0000'   --12.종사업자일련번호	CHAR	4   [사업자단위과세적용사업장이 아닌 경우‘0000’를기재]
        || RPAD(' ', 73, ' ')    --16.공란		CHAR	73
        AS REC
    INTO g_REPORT_CONTENT
    FROM
        (
        SELECT
            --임대차계약내용 합계
              NVL(SUM(DEPOSIT), 0) AS DEPOSIT   --계약내용_보증금
            , NVL(SUM(MONTH_RENT), 0) + NVL(SUM(MONTN_FEE), 0) AS MONTH_RENT   --계약내용_월세등
            
            --과세표준 합계
            , NVL(SUM(DEEMED_RENT), 0) AS DEEMED_RENT   --수입금액_보증금이자
            , NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS TAX_MM_FEE  --수입금액_월세등
            , NVL(SUM(DEEMED_RENT), 0) + NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS RENT_SUM --수입금액_합계(과세표준)          
        FROM FI_BLD_AMT_SPEC
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND OPERATING_UNIT_ID = 42
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL 
        )   ;
        
    INSERT_VAT_E_FILE('부동산임대공급가액명세서', g_REPORT_CONTENT);


    --서식명 : 부동산임대공급가액명세서 , File : 부동산임대공급가액명세서세부, 길이 : 250
    
    FOR REC_2_7 IN (
        SELECT
               '18'     --1.자료구분		CHAR	2
            || 'V120'   --2.서식코드        CHAR	4 
            || '000001' --3.일련번호구분	CHAR	6   [사업자단위과세적용사업장이 아닌 경우 ‘000001’를 기재]
            || LPAD(ROWNUM, 6, '0')             --4.일련번호	        CHAR	6
            || RPAD( CASE
                       WHEN VAT_GROUND_YN = '02' THEN 'B'
                       ELSE ''
                     END || BLD_FLOOR, 10, ' ')         --5.층	                CHAR	10
            || RPAD(NVL(ROOM, ' '), 10, ' ')    --6.호수	            CHAR	10  Null 허용
            || RPAD(LEND_AREA, 10, ' ')         --7.면적	            CHAR	10
            || RPAD(CORP_NAME, 30, ' ')         --8.임차인상호(성명)    CHAR	30
            || RPAD(REPLACE(VAT_NUMBER, '-', ''), 13, ' ')  --9.임차인사업자등록번호 	CHAR	13
            || TO_CHAR(IN_DATE, 'YYYYMMDD')     --10.임대계약입주일	            CHAR	8   Null 허용
            || TO_CHAR(OUT_DATE, 'YYYYMMDD')    --11.임대계약퇴거일	            CHAR	8   Null 허용
            || LPAD(DEPOSIT, 13, 0)             --12.임대계약내용보증금	        NUMBER	13
            || LPAD(MM_FEE, 13, 0)              --13.임대계약내용월임대료	    NUMBER	13
            || LPAD(RENT_SUM, 13, 0)            --14.임대료수입금액계(과세표준)	NUMBER	13
            || LPAD(DEEMED_RENT, 13, 0)         --15.임대료보증금이자	        NUMBER	13
            || LPAD(TAX_MM_FEE, 13, 0)          --16.임대료수입금액월임대료	    NUMBER	13
--            || DECODE(VAT_GROUND_YN, '01', 'N', '02', 'Y')  --17.지하여부	CHAR	1   [Y : 지하,  N : 지상]
            || ' '                              --17.지하여부	null.
            || '0000'   --18.종사업자일련번호	CHAR	4   [사업자단위과세적용사업장이 아닌 경우‘0000’를기재]
            || RPAD(SUBSTR(NVL(ADDRESS, ' '), 1, 30), 30, ' ')          --19.동	    CHAR	30  Null 허용
            || RPAD(NVL(TO_CHAR(MODIFY_DATE, 'YYYYMMDD'), ' '), 8, ' ') --20.갱신일	CHAR	8   Null 허용    
            || RPAD(' ', 35, ' ')   --21.공란	CHAR	35
            AS REC
        FROM
            (
                SELECT
                      SOB_ID	        --회사아이디
                    , ORG_ID	        --사업부아이디
                    , OPERATING_UNIT_ID	--사업장아이디
                    , VAT_MNG_SERIAL	--부가세신고기간구분번호
                    , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --신고기간구분명
                    , SPEC_SERIAL	    --일련번호
                    
                    --임대사항
                    , ADDRESS	        --동
                    , REAL_ESTATE_LOC	--부동산위치    
                    , VAT_GROUND_YN	    --지상_지하여부코드
                    , FI_COMMON_G.CODE_NAME_F('VAT_GROUND_YN', VAT_GROUND_YN, SOB_ID, ORG_ID) AS VAT_GROUND_YN_NM     --지상_지하여부
                    , BLD_FLOOR	--충
                    , ROOM	    --호     
                    , LEND_AREA	--임대면적
                    , PURPOSE	--용도
                    
                    --임차인인적사항 및 임대차계약내용
                    , CORP_NAME	    --업체 상호
                    , VAT_NUMBER	--사업자등록번호
                    , IN_DATE	    --임대기간_입주일
                    , OUT_DATE	    --임대기간_퇴거일    
                    , MODIFY_DATE	--갱신일
                    
                    , DEPOSIT	    --보증금
                    , MONTH_RENT	--월세
                    , MONTN_FEE	    --월관리비
                    , NVL(MONTH_RENT, 0) + NVL(MONTN_FEE, 0) AS MM_FEE --월임대료
                    
                    --임대료수입금액(과세표준)
                    , DEEMED_RENT	--보증금이자(간주임대료)
                    , TERM_RENT	    --임대기간_임대료
                    , TERM_FEE	    --임대기간_관리비
                    , NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS TAX_MM_FEE                        --월임대료(계)
                    , NVL(DEEMED_RENT, 0) + NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS RENT_SUM    --합계
                FROM FI_BLD_AMT_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND OPERATING_UNIT_ID = 42
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                ORDER BY SPEC_SERIAL    
            )
    ) LOOP
    
        INSERT_VAT_E_FILE('부동산임대공급가액명세서세부', REC_2_7.REC);

    END LOOP REC_2_7;


END IF; --IF t_E_FILE_REAL_ESTATE_YN = 'Y' THEN   --전자신고파일생성대상여부_부동산임대공급가액명세서





IF t_E_FILE_BLD_YN = 'Y' THEN           --전자신고파일생성대상여부_건물등감가상각자산취득명세서

    --2-11.건물등감가상각자산취득명세서
    --서식명 : 건물등감가상각자산취득명세서 , File : 건물등감가상각자산취득명세서, 길이 : 200

    FOR REC_2_11 IN (
        SELECT
              9 AS DPR_ASSET_GB_ID  --[9]는 UNION ALL 의 조건을 충족하기 위해 임의의 숫자를 준 것으로 별다른 의미 없다.
            , 5 AS SEQ   --명세서의 감가상각자산종류 번호
            , ' 합                      계' AS DPR_ASSET_GB   --감가상각자산종류
            , TO_NUMBER(DECODE(SUM(ASSET_CNT), 0, NULL, SUM(ASSET_CNT))) AS ASSET_CNT       --건수
            , TO_NUMBER(DECODE(SUM(SUP_AMOUNT), 0, NULL, SUM(SUP_AMOUNT))) AS SUP_AMOUNT    --공급가액
            , TO_NUMBER(DECODE(SUM(SURTAX), 0, NULL, SUM(SURTAX))) AS SURTAX                --부가세         
        FROM FI_DPR_SPEC A
            , FI_SLIP_LINE B
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID     
            AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
            AND B.MANAGEMENT2 = W_OPERATING_UNIT_ID --사업장
            AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
            --AND TO_DATE(B.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630') --신고기준일자
            AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자

        UNION ALL

        SELECT
              A.DPR_ASSET_GB_ID
            , DECODE(A.DPR_ASSET_GB_ID, '1669', 6, '1670', 7, '1671', 8, '1672', 9) AS SEQ   --명세서의 감가상각자산종류 번호
            , A.DPR_ASSET_GB    --감가상각자산종류
            , TO_NUMBER(DECODE(B.ASSET_CNT, 0, NULL, B.ASSET_CNT)) AS ASSET_CNT     --건수
            , TO_NUMBER(DECODE(B.SUP_AMOUNT, 0, NULL, B.SUP_AMOUNT)) AS SUP_AMOUNT  --공급가액
            , TO_NUMBER(DECODE(B.SURTAX, 0, NULL, B.SURTAX)) AS SURTAX              --부가세
        FROM
            (
                SELECT 
                      COMMON_ID AS DPR_ASSET_GB_ID  --건물등감가상각취득명세서_자산구분아이디
                    , VALUE1 AS DPR_ASSET_GB        --감가상각자산종류
                FROM FI_COMMON
                WHERE GROUP_CODE = 'DPR_ASSET_GB'
            ) A
            ,
            (
                SELECT 
                      DPR_ASSET_GB_ID               --건물등감가상각취득명세서_자산구분아이디
                    , NVL(SUM(ASSET_CNT), 0) AS ASSET_CNT   --건수
                    , NVL(SUM(SUP_AMOUNT), 0) AS SUP_AMOUNT --공급가액
                    , NVL(SUM(SURTAX), 0) AS SURTAX         --부가세
                FROM FI_DPR_SPEC A
                    , FI_SLIP_LINE B
                    , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --거래처
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID     
                    AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
                    AND B.MANAGEMENT2 = W_OPERATING_UNIT_ID --사업장
                    AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
                    --AND TO_DATE(B.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630') --신고기준일자
                    AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자
                GROUP BY DPR_ASSET_GB_ID
            ) B
        WHERE A.DPR_ASSET_GB_ID = B.DPR_ASSET_GB_ID(+)
        ORDER BY DPR_ASSET_GB_ID
    ) LOOP
     
        IF REC_2_11.SEQ  = 5 THEN   --합                      계
            t_5_CNT := REC_2_11.ASSET_CNT;
            t_5_AMT := REC_2_11.SUP_AMOUNT;
            t_5_TAX := REC_2_11.SURTAX;
        ELSIF REC_2_11.SEQ  = 6 THEN --(1) 건  물 . 구  축  물
            t_6_CNT := REC_2_11.ASSET_CNT;
            t_6_AMT := REC_2_11.SUP_AMOUNT;
            t_6_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 7 THEN --(2) 기    계    장    치
            t_7_CNT := REC_2_11.ASSET_CNT;
            t_7_AMT := REC_2_11.SUP_AMOUNT;
            t_7_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 8 THEN --(3) 차  량   운  반  구
            t_8_CNT := REC_2_11.ASSET_CNT;
            t_8_AMT := REC_2_11.SUP_AMOUNT;
            t_8_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 9 THEN --(4) 기타감가상각자산
            t_9_CNT := REC_2_11.ASSET_CNT;
            t_9_AMT := REC_2_11.SUP_AMOUNT;
            t_9_TAX := REC_2_11.SURTAX;        
        END IF;
                
    END LOOP REC_2_11;
    


 
    g_REPORT_CONTENT := NULL;
    
    SELECT
           '17'                         --1.자료구분		        CHAR	2
        || 'V149'                       --2.서식코드                CHAR	4 
        || LPAD(NVL(t_5_CNT, 0), 11, 0) --3.건수_합계_고정자산	    NUMBER	11
        || LPAD(NVL(t_5_AMT, 0), 13, 0) --4.공급가액_합계_고정자산	NUMBER	13
        || LPAD(NVL(t_5_TAX, 0), 13, 0) --5.세액_합계_고정자산	    NUMBER	13        
        || LPAD(NVL(t_6_CNT, 0), 11, 0) --6.건수_건물_구축물	    NUMBER	11
        || LPAD(NVL(t_6_AMT, 0), 13, 0) --7.공급가액_건물_구축물	NUMBER	13
        || LPAD(NVL(t_6_TAX, 0), 13, 0) --8.세액_건물_구축물	    NUMBER	13        
        || LPAD(NVL(t_7_CNT, 0), 11, 0) --9.건수_기계장치	        NUMBER	11
        || LPAD(NVL(t_7_AMT, 0), 13, 0) --10.공급가액_기계장치	    NUMBER	13
        || LPAD(NVL(t_7_TAX, 0), 13, 0) --11.세액_기계장치	        NUMBER	13        
        || LPAD(NVL(t_8_CNT, 0), 11, 0) --12.건수_차량운반구	    NUMBER	11
        || LPAD(NVL(t_8_AMT, 0), 13, 0) --13.공급가액_차량운반구	NUMBER	13
        || LPAD(NVL(t_8_TAX, 0), 13, 0) --14.세액_차량운반구	    NUMBER	13        
        || LPAD(NVL(t_9_CNT, 0), 11, 0) --15.건수_기타감가상각	    NUMBER	11
        || LPAD(NVL(t_9_AMT, 0), 13, 0) --16.공급가액_기타감가상각	NUMBER	13
        || LPAD(NVL(t_9_TAX, 0), 13, 0) --17.세액_기타감가상각	    NUMBER	13
        || RPAD(' ', 9, ' ')            --18.공란		            CHAR	9
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('건물등감가상각자산취득명세서', g_REPORT_CONTENT);    


END IF; --IF t_E_FILE_BLD_YN = 'Y' THEN           --전자신고파일생성대상여부_건물등감가상각자산취득명세서





IF t_E_FILE_NO_DEDUCTION_YN = 'Y' THEN  --전자신고파일생성대상여부_공제받지못할매입세액명세서

    --2-12.공제받지못할매입세액명세서
    --서식명 : 공제받지못할매입세액명세서 , File : 공제받지못할매입세액명세서, 길이 : 200
    
    g_REPORT_CONTENT := NULL;            

    SELECT
           '17'  --1.자료구분	CHAR	2
        || 'V153'   --2.서식코드	CHAR	4
        || LPAD(NVL(CNT, 0), 11, 0)  --3.매수합계_세금계산서	NUMBER	11
        || LPAD(NVL(GL_AMOUNT, 0), 15, 0) --4.공급가액합계_세금계산서	NUMBER	15
        || LPAD(NVL(VAT_AMOUNT, 0), 15, 0) --5.매입세액합계_세금계산서	NUMBER	15
        || LPAD(0, 15, 0)   --6.공통매입공급가액합계_안분계산	NUMBER	15
        || LPAD(0, 15, 0)   --7.공통매입세액합계_안분계산	NUMBER	15
        || LPAD(0, 15, 0)   --8.불공제매입세액합계_안분계산	NUMBER	15
        || LPAD(0, 15, 0)   --9.불공제매입세액총액합계_정산내역	NUMBER	15
        || LPAD(0, 15, 0)   --10.기불공제매입세액합계_정산내역	NUMBER	15
        || LPAD(0, 15, 0)   --11.가산/공제매입세액합계_정산내역	NUMBER	15
        || LPAD(0, 15, 0)   --12.가산/공제매입세액합계_납부재계산	NUMBER	15
        || RPAD(' ', 48, ' ')   --13.공란	CHAR	48
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(*) AS CNT
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액 
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                
                --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                AND A.ACCOUNT_CODE IN 
                    (
                        SELECT ACCOUNT_CODE
                        FROM FI_ACCOUNT_CONTROL
                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                            AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                    )  --거래구분(매입/매출)    
                
                AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
                AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                AND REFER1 = '3' --세무유형    
        )   ;
        
    INSERT_VAT_E_FILE('공제받지못할매입세액명세서', g_REPORT_CONTENT);
    
    
    --서식명 : 공제받지못할매입세액명세서 , File : 공제받지못할매입세액명세서_명세, 길이 : 100

    
    FOR REC_2_12 IN (

        SELECT
               '18'     --1.자료구분	CHAR	2
            || 'V153'   --2.서식코드	CHAR	4
            || CODE     --3.불공제사유구분	CHAR	2
            || LPAD(NVL(CNT, 0), 11, 0)         --4.세금계산서매수	NUMBER	11
            || LPAD(NVL(GL_AMOUNT, 0), 13, 0)   --5.공급가액	NUMBER	13
            || LPAD(NVL(VAT_AMOUNT, 0), 13, 0)  --6.매입세액	NUMBER	13    
            || RPAD(' ', 55, ' ')               --7.공란	CHAR	55
            AS REC
        FROM
            (
                SELECT
                      DECODE(B.CODE, '10', '01', '11', '02', '12', '03', '18', '04', '13', '05', '19', '06', '15', '07', '20', '08') AS CODE    --매입세액 불공재 사유코드
                    , B.CODE_NAME   --매입세액 불공재 사유
                    , CNT           --매수
                    , T.GL_AMOUNT   --공급가액
                    , T.VAT_AMOUNT  --매입세액
                    , B.SORT_NUM    --정렬순서
                FROM
                    (
                        SELECT
                              CODE
                            , COUNT(*) AS CNT
                            , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT
                            , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT
                        FROM
                            (
                                SELECT
                                      A.SOB_ID
                                    , A.ORG_ID
                                    , A.REFER3 AS CODE --사유구분코드
                                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
                                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액                 
                                FROM FI_SLIP_LINE A
                                WHERE A.SOB_ID = W_SOB_ID
                                    AND A.ORG_ID = W_ORG_ID
                                    
                                    --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                                    AND A.ACCOUNT_CODE IN 
                                        (
                                            SELECT ACCOUNT_CODE
                                            FROM FI_ACCOUNT_CONTROL
                                            WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                                AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                                        )  --거래구분(매입/매출) 
                                        
                                    AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
                                    AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                                    AND REFER1 = '3' --세무유형 : 매입세액불공제
                            )
                        GROUP BY SOB_ID, ORG_ID, CODE
                    ) T,
                    (   --이 VIEW에서 기준자료를 도출하다.
                        SELECT CODE, CODE_NAME, SORT_NUM
                        FROM FI_COMMON
                        WHERE GROUP_CODE = 'VAT_REASON' AND VALUE2 = '3' AND VALUE3 = 'Y'    
                    ) B
                WHERE B.CODE = T.CODE  
                ORDER BY SORT_NUM     
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('공제받지못할매입세액명세서_명세', REC_2_12.REC);

    END LOOP REC_2_12;


    --참조>아래 3개의 명세는 자료가 없어서 만들지 않는다. 자료가 없는 경우 만들지 않는 것이 전자신고파일의 대전제이다.
    --서식명 : 공제받지못할매입세액명세서 , File : 공제받지못할매입세액명세서_공통매입세액안분계산내역, 길이 : 100
    --서식명 : 공제받지못할매입세액명세서 , File : 공제받지못할매입세액명세서_공통매입세액정산내역, 길이 : 100
    --서식명 : 공제받지못할매입세액명세서 , File : 공제받지못할매입세액명세서_납부세액_환급세액재계산내역, 길이 : 100    
    
END IF; --IF t_E_FILE_NO_DEDUCTION_YN = 'Y' THEN  --전자신고파일생성대상여부_공제받지못할매입세액명세서






IF t_E_FILE_TAX_PUB_YN = 'Y' THEN          --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서

    --2-24.전자세금계산서 발급세액공제신고서
    --서식명 : 전자세금계산서 발급세액공제신고서 , File : 전자세금계산서 발급세액공제신고서, 길이 : 100

    g_REPORT_CONTENT := NULL;            

    SELECT
           '17'     --1.자료구분    CHAR	2
        || 'V171'   --2.서식코드	CHAR	4
        || LPAD(NVL(ELEC_TAX_PUB_CNT, 0), 7, 0)         --3.전자세금계산서발급건수	NUMBER	7
        || LPAD(NVL(ELEC_TAX_PUB_CNT * 200, 0), 13, 0)  --4.공제가능세액	        NUMBER	13
        || LPAD(
                  CASE 
                    WHEN NVL(ELEC_TAX_PUB_CNT * 200, 0) < (1000000 - NVL(DEDUCT_TAX, 0)) THEN NVL(ELEC_TAX_PUB_CNT * 200, 0)
                    ELSE (1000000 - NVL(DEDUCT_TAX, 0))
                  END        
                , 13, 0) --5.해당공제세액	NUMBER	13
        || LPAD(NVL(DEDUCT_TAX, 0), 13, 0)              --6.기공제세액	NUMBER	13
        || LPAD(1000000 - NVL(DEDUCT_TAX, 0), 13, 0)    --7.해당과세기간공제한도액	NUMBER	13
        || RPAD(' ', 35, ' ')   --8.공란	CHAR	35
    INTO g_REPORT_CONTENT
    FROM FI_ELEC_TAX_PUB
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;    
        
    INSERT_VAT_E_FILE('전자세금계산서 발급세액공제신고서', g_REPORT_CONTENT);

END IF;    --IF t_E_FILE_TAX_PUB_YN = 'Y' THEN          --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서









IF t_E_FILE_DOMESTIC_LC_YN = 'Y' THEN   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서

    --2-27.내국신용장구매확인서전자발급명세서
    --서식명 : 내국신용장구매확인서전자발급명세서_합계 , File : 내국신용장구매확인서전자발급명세서, 길이 : 100

    g_REPORT_CONTENT := NULL;            

    SELECT
           '17'     --1.자료구분    CHAR	2
        || 'V174'   --2.서식코드	CHAR	4
        || LPAD(A.CNT, 7, 0)    --3.건수_합계	NUMBER	7
        || LPAD(A.TOTAL, 15, 0) --4.해당금액_합계	NUMBER	15
        || LPAD(B.CNT, 7, 0)    --5.내국신용장_건수_합계	NUMBER	7
        || LPAD(B.TOTAL, 15, 0) --6.내국신용장_금액_합계	NUMBER	15
        || LPAD(C.CNT, 7, 0)    --7.구매확인서_건수_합계	NUMBER	7
        || LPAD(C.TOTAL, 15, 0) --8.구매확인서_금액_합계	NUMBER	15 
        || RPAD(' ', 28, ' ')   --9.공란	CHAR	28
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(*) AS CNT   --건수
                , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --금액(원)
            FROM FI_DOMESTIC_LC
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID --사업장아이디
                AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
        ) A --합계
        ,
        (
            SELECT
                  COUNT(*) AS CNT   --건수
                , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --금액(원)
            FROM FI_DOMESTIC_LC
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID --사업장아이디
                AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
                AND VAT_DOMESTIC_LC_CD = '01'   --01 : 내국신용장
        ) B --내국신용장    
        ,
        (
            SELECT
                  COUNT(*) AS CNT   --건수
                , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --금액(원)
            FROM FI_DOMESTIC_LC
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID --사업장아이디
                AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
                AND VAT_DOMESTIC_LC_CD = '02'   --02 : 구매확인서
        ) C --구매확인서   
    ;        
        
    INSERT_VAT_E_FILE('내국신용장구매확인서전자발급명세서_합계', g_REPORT_CONTENT);
    
    
    
    --서식명 : 내국신용장구매확인서전자발급명세서_명세 , File : 내국신용장구매확인서전자발급명세서_명세, 길이 : 100
  
    FOR REC_2_27 IN (

        SELECT
               '18'     --1.자료구분    CHAR	2
            || 'V174'   --2.서식코드	CHAR	4
            || LPAD(ROWNUM, 6, 0)       --3.일련번호	    NUMBER	6
            || VAT_DOMESTIC_LC_CD       --4.서류구분	CHAR	1
            || RPAD(DOC_NO, 35, ' ')    --5.서류번호	CHAR	35
            || PUB_DATE	                --6.발급일자	CHAR	8
            || VAT_NUMBER	            --7.공급받는자 사업자등록번호	CHAR	10
            || LPAD(SUPPLY_AMT, 15, 0)  --8.금액	NUMBER	15
            || RPAD(' ', 19, ' ')       --9.공란	CHAR	19
            AS REC
        FROM
            (
                SELECT
                      DECODE(VAT_DOMESTIC_LC_CD, '01', 'L', '02', 'A') AS VAT_DOMESTIC_LC_CD    --서류구분         
                    , DOC_NO    --서류번호
                    , TO_CHAR(PUB_DATE, 'YYYYMMDD') AS PUB_DATE --발급일
                    , RPAD(REPLACE(VAT_NUMBER, '-', ''), 10, ' ') AS VAT_NUMBER --사업자등록번호
                    , SUPPLY_AMT    --금액
                FROM FI_DOMESTIC_LC       
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID --사업장아이디
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
                ORDER BY VAT_DOMESTIC_LC_CD DESC, PUB_DATE
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('내국신용장구매확인서전자발급명세서_명세', REC_2_27.REC);

    END LOOP REC_2_27;    

END IF;    --IF t_E_FILE_DOMESTIC_LC_YN = 'Y' THEN   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서










--3.전산매체 테이블



IF t_E_FILE_SUM_VAT_YN = 'Y' THEN       --전자시고파일생성대상여부_세금계산서합계표

    --3-1.세금계산서합계표
    --서식명 : 표지(Head Record)  길이 : 170
    
    g_REPORT_CONTENT := NULL;            

    SELECT
           '7'                  --1.자료구분	        CHAR	1
        || t_VAT_NUMBER_10      --2.보고자등록번호	    NUMBER	10        
        || t_CORP_NAME_30       --3.보고자상호	        CHAR	30
        || t_PRESIDENT_NAME_15  --4.보고자성명	        CHAR	15
        || t_LOCATION_45        --5.보고자사업장소재지	CHAR	45
        || RPAD(' ', 17, ' ')    --6.보고자업태	        CHAR	17
        || RPAD(' ', 25, ' ')   --7.보고자종목	        CHAR	25
        || RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYMMDD'), 12, ' ')  --8.거래기간	NUMBER	12
        || LPAD(TO_CHAR(W_CREATE_DATE, 'YYMMDD'), 6, 0)    --9.작성일자	NUMBER	6        
        || RPAD(' ', 9, ' ')   --10.공란	CHAR	9
    INTO g_REPORT_CONTENT
    FROM DUAL   ;
        
    INSERT_VAT_E_FILE('세금계산서합계표 표지(Head Record)', g_REPORT_CONTENT);


    --서식명 : (전자세금계산서 이외분)매출자료(Data Record)  길이 : 170
    
    FOR REC_4_1 IN (

        SELECT
                '1'                 --1.자료구분	    CHAR	1
            || t_VAT_NUMBER_10      --2.보고자등록번호	NUMBER	10  Null 허용 [사업자번호]
            || LPAD(ROWNUM, 4, 0)   --3.일련번호	    NUMBER	4
            || RPAD(REPLACE(NVL(TAX_REG_NO, ' '), '-', ''), 10, ' ')    --4.거래자등록번호	NUMBER	10  [사업자번호]
            || RPAD(NVL(SUPPLIER_NAME, ' '), 30, ' ')                   --5.거래자상호	    CHAR	30  Null 허용
            || RPAD(' ', 17, ' ')       --6.거래자업태	    CHAR	17  SPACE
            || RPAD(' ', 25, ' ')       --7.거래자종목	    CHAR	25  SPACE
            || LPAD(COMPANY_CNT, 7, 0)  --8.세금계산서매수	NUMBER	7
            || LPAD(0, 2, 0)            --9.공란수	        NUMBER	2
            
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 14, '0') --10.공급가액	NUMBER	14
            || LPAD(
                    CASE
                        WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                        ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                            CASE SUBSTR(VAT_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 13, '0') --11.세액	NUMBER	13            
            
            || '0'      --12.신고자주류코드(도매)	NUMBER	1   [기타 업종인 경우에는 "0"을 수록]
            || '0'      --13.주류코드(소매)	        NUMBER	1   [기타 업종인 경우에는 "0"을 수록]
            || '7501'   --14.권번호	                NUMBER	4
            || RPAD(' ', 3, ' ')    --15.제출서	    NUMBER	3 Null 허용
            || RPAD(' ', 28, ' ')   --16.공란	    CHAR	28 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --거래처코드
                    , B.TAX_REG_NO                    --사업자등록번호      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
                    , AA.COMPANY_CNT  --매수
                    
                    , AA.GL_AMOUNT     --공급가액
                    , AA.VAT_AMOUNT    --세액        
                    
                    , B.PRESIDENT_NAME        --대표자성명
                    , B.BUSINESS_CONDITION    --업태
                    , B.BUSINESS_ITEM         --종목
                FROM
                    (
                        SELECT             
                              A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                            , COUNT(*) AS COMPANY_CNT --매수
                            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                        FROM FI_SLIP_LINE A
                        WHERE A.SOB_ID = W_SOB_ID
                            AND A.ORG_ID = W_ORG_ID 
                            AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                            AND A.REFER11 = W_OPERATING_UNIT_ID         --사업장
                            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                            AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                            AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --전자세금계산서여부
                        GROUP BY  A.MANAGEMENT1 
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --코드
                            , SUPP_CUST_NAME        --상호
                            , TAX_REG_NO            --사업자등록번호
                            , PRESIDENT_NAME        --대표자성명
                            , BUSINESS_CONDITION    --업태
                            , BUSINESS_ITEM         --종목
                        FROM FI_SUPP_CUST_V) B  --거래처    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO        
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('세금계산서합계표 (전자세금계산서 이외분)매출자료(Data Record)', REC_4_1.REC);

    END LOOP REC_4_1;

    
    --서식명 : (전자세금계산서 이외분)매출합계(Total Record)  길이 : 170

    g_REPORT_CONTENT := NULL;            

    SELECT
           '3'              --1.자료구분	    CHAR	1
        || t_VAT_NUMBER_10  --2.보고자등록번호	NUMBER	10  Null 허용
        
        --(합계분)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.세액	NUMBER	14
        
        --(사업자번호발행분)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.세액	NUMBER	14    
        
        --(주민번호발행분)		
        || LPAD(0, 7, 0)    --11.거래처수	    NUMBER	7
        || LPAD(0, 7, 0)    --12.세금계산서매수	NUMBER	7
        || LPAD(0, 15, 0)   --13.공급가액	    NUMBER	15
        || LPAD(0, 14, 0)   --14.세액	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.공란	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --매수
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --공급가액
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --세액                
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                        AND A.REFER11 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                        AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1
                ) TC    
        )   ;
        
    INSERT_VAT_E_FILE('세금계산서합계표 (전자세금계산서 이외분)매출합계(Total Record)', g_REPORT_CONTENT);



    --서식명 : 전자세금계산서분 매출합계(Total Record)  길이 : 170

    g_REPORT_CONTENT := NULL;            


    SELECT
           '5'              --1.자료구분	    CHAR	1
        || t_VAT_NUMBER_10  --2.보고자등록번호	NUMBER	10  Null 허용
        
        --(합계분)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.세액	NUMBER	14
        
        --(사업자번호발행분)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.세액	NUMBER	14    
        
        --(주민번호발행분)		
        || LPAD(0, 7, 0)    --11.거래처수	    NUMBER	7
        || LPAD(0, 7, 0)    --12.세금계산서매수	NUMBER	7
        || LPAD(0, 15, 0)   --13.공급가액	    NUMBER	15
        || LPAD(0, 14, 0)   --14.세액	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.공란	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --매수
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --공급가액
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --세액                
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                        AND A.REFER11 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                        AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1 
                ) TB  
        )   ;
        
    INSERT_VAT_E_FILE('세금계산서합계표 전자세금계산서분 매출합계(Total Record)', g_REPORT_CONTENT);



    --서식명 : (전자세금계산서 이외분)매입자료(Data Record)  길이 : 170
    
    FOR REC_4_2 IN (

        SELECT
                '2'                 --1.자료구분	    CHAR	1
            || t_VAT_NUMBER_10      --2.보고자등록번호	NUMBER	10  Null 허용 [사업자번호]
            || LPAD(ROWNUM, 4, 0)   --3.일련번호	    NUMBER	4
            || RPAD(REPLACE(NVL(TAX_REG_NO, ' '), '-', ''), 10, ' ')    --4.거래자등록번호	NUMBER	10  [사업자번호]
            || RPAD(NVL(SUPPLIER_NAME, ' '), 30, ' ')                   --5.거래자상호	    CHAR	30  Null 허용
            || RPAD(' ', 17, ' ')       --6.거래자업태	    CHAR	17  SPACE
            || RPAD(' ', 25, ' ')       --7.거래자종목	    CHAR	25  SPACE
            || LPAD(COMPANY_CNT, 7, 0)  --8.세금계산서매수	NUMBER	7
            || LPAD(0, 2, 0)            --9.공란수	        NUMBER	2
            
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 14, '0') --10.공급가액	NUMBER	14
            || LPAD(
                    CASE
                        WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                        ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                            CASE SUBSTR(VAT_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 13, '0') --11.세액	NUMBER	13            
            
            || '0'      --12.신고자주류코드(도매)	NUMBER	1   [기타 업종인 경우에는 "0"을 수록]
            || '0'      --13.주류코드(소매)	        NUMBER	1   [기타 업종인 경우에는 "0"을 수록]
            || '8501'   --14.권번호	                NUMBER	4
            || RPAD(' ', 3, ' ')    --15.제출서	    NUMBER	3 Null 허용
            || RPAD(' ', 28, ' ')   --16.공란	    CHAR	28 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --거래처코드
                    , B.TAX_REG_NO                    --사업자등록번호      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
                    , AA.COMPANY_CNT  --매수
                    
                    , AA.GL_AMOUNT     --공급가액
                    , AA.VAT_AMOUNT    --세액        
                    
                    , B.PRESIDENT_NAME        --대표자성명
                    , B.BUSINESS_CONDITION    --업태
                    , B.BUSINESS_ITEM         --종목        
                FROM
                    (
                    SELECT
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS COMPANY_CNT           --매수     
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액     
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --전자세금계산서여부
                    GROUP BY A.MANAGEMENT1
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --코드
                            , SUPP_CUST_NAME        --상호
                            , TAX_REG_NO            --사업자등록번호
                            , PRESIDENT_NAME        --대표자성명
                            , BUSINESS_CONDITION    --업태
                            , BUSINESS_ITEM         --종목
                        FROM FI_SUPP_CUST_V) B  --거래처    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO    
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('세금계산서합계표 (전자세금계산서 이외분)매입자료(Data Record)', REC_4_2.REC);

    END LOOP REC_4_2;



    --서식명 : (전자세금계산서 이외분)매입합계(Total Record)  길이 : 170

    g_REPORT_CONTENT := NULL;            

    SELECT
           '4'              --1.자료구분	    CHAR	1
        || t_VAT_NUMBER_10  --2.보고자등록번호	NUMBER	10  Null 허용
        
        --(합계분)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.세액	NUMBER	14
        
        --(사업자번호발행분)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.세액	NUMBER	14    
        
        --(주민번호발행분)		
        || LPAD(0, 7, 0)    --11.거래처수	    NUMBER	7
        || LPAD(0, 7, 0)    --12.세금계산서매수	NUMBER	7
        || LPAD(0, 15, 0)   --13.공급가액	    NUMBER	15
        || LPAD(0, 14, 0)   --14.세액	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.공란	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (


            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --매수
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --공급가액
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --세액             
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1  
                ) TC  
        )   ;
        
    INSERT_VAT_E_FILE('세금계산서합계표 (전자세금계산서 이외분)매입합계(Total Record)', g_REPORT_CONTENT);



    --서식명 : 전자세금계산서분 매입합계(Total Record)  길이 : 170

    g_REPORT_CONTENT := NULL;            


    SELECT
           '6'              --1.자료구분	    CHAR	1
        || t_VAT_NUMBER_10  --2.보고자등록번호	NUMBER	10  Null 허용
        
        --(합계분)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.세액	NUMBER	14
        
        --(사업자번호발행분)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.거래처수	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.세금계산서매수	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.공급가액	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.세액	NUMBER	14    
        
        --(주민번호발행분)		
        || LPAD(0, 7, 0)    --11.거래처수	    NUMBER	7
        || LPAD(0, 7, 0)    --12.세금계산서매수	NUMBER	7
        || LPAD(0, 15, 0)   --13.공급가액	    NUMBER	15
        || LPAD(0, 14, 0)   --14.세액	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.공란	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --매수
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --공급가액
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --세액                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1   
                ) TB 
        )   ;
        
    INSERT_VAT_E_FILE('세금계산서합계표 전자세금계산서분 매입합계(Total Record)', g_REPORT_CONTENT);


END IF; --IF t_E_FILE_SUM_VAT_YN = 'Y' THEN       --전자시고파일생성대상여부_세금계산서합계표



IF t_E_FILE_SUM_CALC_YN = 'Y' THEN      --전자신고파일생성대상여부_계산서합계표

    --3-2.계산서합계표
    --서식명 : 제출자(대리인)레코드 , 길이 : 230

    g_REPORT_CONTENT := NULL;            

    SELECT
           'A'                  --1.레코드구분	CHAR	1
        || t_TAX_OFFICE_CODE    --2.세무서	    CHAR	3   Null 허용
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')    --3.제출년월일	NUMBER	8
        || '2'   --4.제출자구분	NUMBER	1   [(1: 세무대리인, 2: 법인, 3:개인) ]
        || RPAD(' ', 6, ' ')                    --5.세무대리인관리번호	CHAR	6   [세무대리인이 아닌 경우에는 공란(space)으로 수록]
        || t_VAT_NUMBER_10                      --6.사업자등록번호	    CHAR	10
        || RPAD(t_CORP_NAME_30, 40, ' ')        --7.법인명(상호)	    CHAR	40
        || t_LEGAL_NUMBER                       --8.주민(법인)등록번호	CHAR	13
        || t_PRESIDENT_NAME_30                  --9.대표자(성명)	    CHAR	30
        || RPAD(NVL(t_ZIP_CODE, ' '), 10, ' ')  --10.소재지(우편번호)법정동코드	CHAR	10  Null 허용
        || t_LOCATION_70    --11.소재지(주소)	CHAR	70
        || t_VAT_TEL        --12.전화번호	    CHAR	15
        
        --사업자는 1개이므로 임의로 1로 고정한다.
        || LPAD(1, 5, 0)   --13.제출건수계	NUMBER	5   [제출의무자(사업자) 수(B레코드의 수)를 수록]
        
        || '101'                --14.사용한한글코드종류	NUMBER	3
        || RPAD(' ', 15, ' ')   --15.공란	            CHAR	15
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('계산서합계표 제출자(대리인)레코드', g_REPORT_CONTENT);


    --서식명 : 제출의무자인적사항레코드 , 길이 : 230


    g_REPORT_CONTENT := NULL;            

    SELECT
           'B'                                  --1.레코드구분	    CHAR	1
        || t_TAX_OFFICE_CODE                    --2.세무서	        CHAR	3   Null 허용
        || '000001'                             --3.일련번호	    NUMBER	6
        || t_VAT_NUMBER_10                      --4.사업자등록번호	CHAR	10
        || RPAD(t_CORP_NAME_30, 40, ' ')        --5.법인명(상호)	CHAR	40
        || t_PRESIDENT_NAME_30                  --6.대표자(성명)	CHAR	30
        || RPAD(NVL(t_ZIP_CODE, ' '), 10, ' ')  --7.사업장(우편번호)법정동코드	CHAR	10  Null 허용
        || t_LOCATION_70                        --8.사업장소재지(주소)	CHAR	70
        || RPAD(' ', 60, ' ')                   --9.공란	            CHAR	60
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('계산서합계표 제출의무자인적사항레코드', g_REPORT_CONTENT);






    --참조>아래 2개의 명세는 자료가 없어서 만들지 않는다. 
    --    이는 [제출할 필요 없는 첨부서류는 수록하지 않아야 합니다. ]와는 그 취지가 좀 다르다. 
    --    매출계산서 합계표는 제출할 필요가 없는 게 아니라 자료가 없어서 안 만든것이다.
    --.서식명 : 제출의무자별집계레코드(매출)  길이 : 230
    --.서식명 : 매출처별거래명세레코드  길이 : 230





    
    --.서식명 : 제출의무자별집계레코드(매입)  길이 : 230

    g_REPORT_CONTENT := NULL;            

    SELECT
           'C'  --1.레코드구분	CHAR	1
        || '18' --2.자료구분	NUMBER	2
        ||  CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
            END --3.기구분	CHAR	1
        ||  CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- 예정신고
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- 확정신고
            END --4.신고구분	CHAR	1   [예정이면 1, 확정이면 2]
        || t_TAX_OFFICE_CODE    --5.세무서	        CHAR	3   Null 허용
        || '000001'             --6.일련번호	    NUMBER	6
        || t_VAT_NUMBER_10      --7.사업자등록번호	CHAR	10
        || LPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, 0)     --8.귀속년도	        NUMBER	4   Null 허용
        || LPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, 0) --9.거래기간시작년월일	NUMBER	8   Null 허용
        || LPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, 0) --10.거래기간종료년월일	NUMBER	8   Null 허용
        || LPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, 0)   --11.작성일자	        NUMBER	8   Null 허용
        || LPAD(COMPANY_CNT, 6, 0)   --12.매입처수합계	    NUMBER	6
        || LPAD(TOTAL_RECORD, 6, 0)  --13.계산서매수합계	NUMBER	6
        || CASE 
                WHEN GL_AMOUNT >= 0 THEN 0
                ELSE 1
           END                      --14.매입금액합계음수표시	NUMBER	1
        || LPAD(GL_AMOUNT, 14, 0)   --15.매입금액합계	        NUMBER	14
        || RPAD(' ', 151, ' ')      --16.공란	                CHAR	151
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  '합  계' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
                , NVL(SUM(CNT), 0) AS TOTAL_RECORD --매수
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT --공급가액
                , LENGTH(NVL(SUM(GL_AMOUNT), 0)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.REFER1 = '4'  --세무유형 
                    GROUP BY  A.MANAGEMENT1 
                ) AA     
        )   ;  
        
    INSERT_VAT_E_FILE('계산서합계표 제출의무자별집계레코드(매입)', g_REPORT_CONTENT);



    --.서식명 : 매입처별거래명세레코드  길이 : 230

    FOR REC_TAX IN (

        SELECT
               'D'  --1.레코드구분	CHAR	1
            || '18' --2.자료구분	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.기구분	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- 예정신고
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- 확정신고
                END --4.신고구분	CHAR	1   [예정이면 1, 확정이면 2]
            || t_TAX_OFFICE_CODE    --5.세무서	        CHAR	3   Null 허용            
            || LPAD(ROWNUM, 6, 0)   --6.일련번호	    NUMBER	6
            || t_VAT_NUMBER_10      --7.사업자등록번호	CHAR	10
            || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.매입처사업자등록번호	CHAR	10
            || RPAD(SUPPLIER_NAME, 40, ' ')                 --9.매입처법인명(상호)	    CHAR	40
            || LPAD(COMPANY_CNT, 5, 0)                      --10.계산서매수	            NUMBER	5
            || CASE 
                    WHEN GL_AMOUNT >= 0 THEN 0
                    ELSE 1
               END  --11.매입금액음수표시	NUMBER	1
            --|| LPAD(GL_AMOUNT, 14, 0)   --12.매입금액	NUMBER	14
            || LPAD(ABS(GL_AMOUNT), 14, 0)   --12.매입금액	NUMBER	14
            || RPAD(' ', 136, ' ')      --13.공란	    CHAR	136 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --거래처코드
                    , B.TAX_REG_NO                    --사업자등록번호      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
                    , AA.COMPANY_CNT  --매수                 
                    , AA.GL_AMOUNT     --공급가액                    
                    , B.PRESIDENT_NAME        --대표자성명
                    , B.BUSINESS_CONDITION    --업태
                    , B.BUSINESS_ITEM         --종목
                FROM
                    (
                    SELECT
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS COMPANY_CNT           --매수     
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액     
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입
                        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID         --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                        AND A.REFER1 = '4'  --세무유형
                    GROUP BY A.MANAGEMENT1
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --코드
                            , SUPP_CUST_NAME        --상호
                            , TAX_REG_NO            --사업자등록번호
                            , PRESIDENT_NAME        --대표자성명
                            , BUSINESS_CONDITION    --업태
                            , BUSINESS_ITEM         --종목
                        FROM FI_SUPP_CUST_V) B  --거래처    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO    
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('계산서합계표 매입처별거래명세레코드', REC_TAX.REC);

    END LOOP REC_TAX;


END IF; --IF t_E_FILE_SUM_CALC_YN = 'Y' THEN      --전자신고파일생성대상여부_계산서합계표




IF t_E_FILE_EXPORT_YN = 'Y' THEN        --전자신고파일생성대상여부_수출실적명세서

    --3-3.수출실적명세서
    --.서식명 : A 레코드(표지)   길이 : 180

    g_REPORT_CONTENT := NULL;            

    SELECT
           'A'  --1.자료구분_표지	CHAR	1
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.수출신고년월(귀속년월)	CHAR	6   [거래기간의 종료년월]
        || '3'              --3.신고구분	    CHAR	1   [3 개월분인 경우 3]
        || t_VAT_NUMBER_10  --4.사업자등록번호	CHAR	10
        || t_CORP_NAME_30   --5.법인명(상호)	CHAR	30
        || RPAD(t_PRESIDENT_NAME_30, 15, ' ')   --6.성명(대표자명)_수출	CHAR	15
        || RPAD(t_LOCATION_70, 45, ' ')         --7.사업장소재지_수출	CHAR	45
        || RPAD(g_BUSINESS_ITEM_30, 17, ' ')    --8.업태명_수출	        CHAR	17
        || RPAD(g_BUSINESS_TYPE_50, 25, ' ')    --9.종목명_수출	        CHAR	25        
        || RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ')
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ')   --10.거래기간	CHAR	16  [신고기간의 첫날과 마지막날]
        || RPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, 0)       --11.작성일자   CHAR	8                
        || RPAD(' ', 6, ' ')   --12.공란	CHAR	6
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('수출실적명세서 A 레코드(표지)', g_REPORT_CONTENT);    


    
    --.서식명 : B 레코드(합계)   길이 : 180

    FOR REC_EXPORT IN (

        SELECT
              '9' SEQ
            , '합             계' AS GUBUN    --구분
            , COUNT(*) AS DATA_CNT            --건수
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --외화금액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
            AND MANAGEMENT2 = '3'           --세무유형 : 수출        
            AND A.REFER11 = W_OPERATING_UNIT_ID --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자

        UNION ALL

        SELECT
             '10' SEQ
            , '수  출   재  화' AS GUBUN    --구분
            , COUNT(*) AS DATA_CNT          --건수
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --외화금액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
            AND MANAGEMENT2 = '3'           --세무유형 : 수출 
            AND A.REFER4 IS NOT NULL
            AND A.REFER11 = W_OPERATING_UNIT_ID --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자

        UNION ALL

        SELECT
             '11' SEQ
            , '기타영세율적용' AS GUBUN    --구분
            , COUNT(*) AS DATA_CNT         --건수
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --외화금액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
            AND MANAGEMENT2 = '3'           --세무유형 : 수출    
            AND A.REFER4 IS NULL
            AND A.REFER11 = W_OPERATING_UNIT_ID --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자
            
    ) LOOP

        IF REC_EXPORT.SEQ  = 9 THEN   --'합             계'
            t_EXP_SUM_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_SUM_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_SUM_KOR := REC_EXPORT.GL_AMOUNT;
        ELSIF REC_EXPORT.SEQ  = 10 THEN --'수  출   재  화'
            t_EXP_ITEM_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_ITEM_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_ITEM_KOR := REC_EXPORT.GL_AMOUNT;        
        ELSIF REC_EXPORT.SEQ  = 11 THEN --'기타영세율적용'
            t_EXP_OTHER_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_OTHER_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_OTHER_KOR := REC_EXPORT.GL_AMOUNT;              
        END IF;
                
    END LOOP REC_EXPORT;
    

    g_REPORT_CONTENT := NULL;
    
    SELECT
           'B'  --1.자료구분_합계	 CHAR	1
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.수출신고년월(귀속년월)	CHAR	6   [거래기간의 종료년월]
        || '3'              --3.신고구분	    CHAR	1   [3 개월분인 경우 3]
        || t_VAT_NUMBER_10  --4.사업자등록번호	CHAR	10               

        --음수인 경우 멀티키(Multi-Key) 사용을 해야하는데, 그럴일이 없어서 처리안한다.
        || LPAD(NVL(t_EXP_SUM_CNT, 0), 7, 0)    --5.건수합계_수출	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_SUM_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --6.외화금액_합계	 NUMBER	15,2
        || LPAD(NVL(t_EXP_SUM_KOR, 0), 15, 0)   --7.원화금액_합계	 NUMBER	15        
        || LPAD(NVL(t_EXP_ITEM_CNT, 0), 7, 0)    --8.건수_재화	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_ITEM_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --9.외화금액_재화	 NUMBER	15,2
        || LPAD(NVL(t_EXP_ITEM_KOR, 0), 15, 0)   --10.원화금액_재화	 NUMBER	15        
        || LPAD(NVL(t_EXP_OTHER_CNT, 0), 7, 0)    --11.건수_기타	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_OTHER_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --12.외화금액_기타	 NUMBER	15,2
        || LPAD(NVL(t_EXP_OTHER_KOR, 0), 15, 0)   --13.원화금액_기타	 NUMBER	15
        
        || RPAD(' ', 51, ' ')    --14.공 란	 CHAR	51
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('수출실적명세서 B 레코드(합계)', g_REPORT_CONTENT);   
    
    
    
    
    --.서식명 : C 레코드(자료)   길이 : 180

    FOR REC_EXP_OUTPUT IN (

        SELECT
               'C'   --1.자료구분_자료	 CHAR	 1
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.수출신고년월(귀속년월)	CHAR	6   [거래기간의 종료년월]
            || '3'              --3.신고구분	    CHAR	1   [3 개월분인 경우 3]
            || t_VAT_NUMBER_10  --4.사업자등록번호	CHAR	10             
            || LPAD(ROWNUM, 7, 0)                               --5.수출일련번호  CHAR    7
            || RPAD(REPLACE(EXPORT_NO, '-', ''), 15, ' ')       --6.수출신고번호  CHAR    15
            || RPAD(REPLACE(VAT_ISSUE_DATE, '-', ''), 8, ' ')   --7.선적(기)일자  CHAR    8
            || RPAD(CURRENCY_CODE, 3, ' ')                      --8.수출통화코드  CHAR    3
            || LPAD(REPLACE(EXCHANGE_RATE, '.', ''), 9, 0)      --9.환    율      NUMBER  9,4
            
            || LPAD(REPLACE(CURRENCY_AMOUNT, '.', ''), 15, 0)   --10.외화금액     NUMBER  15,2
                       
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 15, '0') --11.원화금액	 NUMBER	 15


            || RPAD(' ', 90, ' ')       --12.공    란	 CHAR	 90 
            AS REC
        FROM 
            (
                SELECT
                      A.REFER4 AS EXPORT_NO         --수출신고번호 
                    , A.REFER1 AS VAT_ISSUE_DATE    --선(기)적일자 ; 신고기준일자        
                    , A.REFER3 AS CURRENCY_CODE     --통화코드
                    , TO_CHAR(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')), 'FM99999.0000') AS EXCHANGE_RATE     --환율
                    , TO_CHAR(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')), 'FM999999999999.00') AS CURRENCY_AMOUNT   --외화금액
                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --원화; 공급가액            
                FROM FI_SLIP_LINE A
                WHERE   A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
                    AND MANAGEMENT2 = '3'           --세무유형 : 수출
                    AND A.REFER4 IS NOT NULL
                    AND A.REFER11 = W_OPERATING_UNIT_ID --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
                    
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자        
                ORDER BY VAT_ISSUE_DATE            
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('수출실적명세서  C 레코드(자료)', REC_EXP_OUTPUT.REC);

    END LOOP REC_EXP_OUTPUT;


END IF; --IF t_E_FILE_EXPORT_YN = 'Y' THEN        --전자신고파일생성대상여부_수출실적명세서



IF t_E_FILE_GET_YN = 'Y' THEN           --전자신고파일생성대상여부_신용카드매출전표등수취명세서

    --3-4.신용카드매출전표등수취명세서(갑,을)
    --.서식명 : 제출자 인적사항(Header Record)   길이 : 140



    g_REPORT_CONTENT := NULL;
    
    SELECT
           'HL'   --1.레코드구분	CHAR	2
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.귀속년도	CHAR	4
        || RPAD(
                CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
                END
           , 1, ' ') --3.반기구분	CHAR	1
        || RPAD(
                CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                END
           , 1, ' ') --4.반기내월순번	CHAR	1                             
        || t_VAT_NUMBER_10                      --5.수취자(제출자)사업자등록번호	CHAR	10
        || RPAD(t_CORP_NAME_30, 60, ' ')        --6.상호(법인명)	CHAR	60
        || t_PRESIDENT_NAME_30                  --7.성명(대표자)	CHAR	30
        || t_LEGAL_NUMBER                       --8.주민(법인)등록번호	CHAR	13
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')   --9.제출일자	CHAR	8
        || RPAD(' ', 11, ' ')                   --10.공란	CHAR	11
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('신용카드매출전표등수취명세서(갑,을) 제출자 인적사항(Header Record)', g_REPORT_CONTENT);   




    --.서식명 : 신용/직불카드 및 기명식선불카드 매출전표 수취명세(Data Record)   길이 : 140
    
    --현금영수증의 자료유무를 판단한다.
    SELECT COUNT(*)
    INTO t_CASH_CNT
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)     
        
        AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
        AND REFER1 = '7'    --세무유형 : 현금영수증매입     
    ; 
    
    
    --본  IF문에 있는 문장은 동일하다 단지 UNION하단의 현금영수증 자료를 포함하느냐 아니냐의 차이일 뿐이다.
    IF t_CASH_CNT > 0 THEN

        FOR REC_GET_OUTPUT IN (    

            SELECT
                 ROWNUM AS SEQ --일련번호 ; [신용카드등 매입내용 합계(Tail Record)] 명세서에서 사용함.
               , 'DL'  --1.레코드구분	CHAR	2
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.귀속년도	CHAR	4
            || RPAD(
                    CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                    END
               , 1, ' ') --3.반기구분	CHAR	1
            || RPAD(
                    CASE 
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                    END
               , 1, ' ') --4.반기내월순번	CHAR	1 
               
                || t_VAT_NUMBER_10                              --5.수취자(제출자)사업자등록번호	CHAR	10
                || CARD_GB                                      --6.카드구분	                    CHAR	1
                || RPAD(NVL(REPLACE(CARD_NUM, '-', ''), ' '), 20, ' ')    --7.카드회원번호	                CHAR	20
                || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.공급자(가맹점)사업자등록번호	CHAR	10
                || LPAD(CNT, 9, 0)                              --9.거래건수	                    NUMBER	9
                || RPAD(CASE WHEN GL_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --10.(공급가액)음수표시	CHAR	1
                || LPAD(GL_AMOUNT, 13, 0)                                           --11.공급가액	        NUMBER	13
                || RPAD(CASE WHEN VAT_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --12.(세액)음수표시	    CHAR	1
                || LPAD(VAT_AMOUNT, 13, 0)                                          --13.세액	            NUMBER	13
                || RPAD(' ', 54, ' ')   --14.공란	CHAR	54
                AS REC
            FROM
            (

                SELECT 
                    '1' AS CARD_GB   --카드구분 : 신용카드 및 직불카드 자료라면 ‘1’
                    , CARD_NUM      --카드회원번호
                    , TAX_REG_NO    --사업자등록번호
                    , CNT           --거래건수
                    , GL_AMOUNT     --공급가액
                    , VAT_AMOUNT    --세액
                FROM
                    (
                        SELECT        
                              CARD_NUM
                            , TAX_REG_NO
                            , COUNT(*) AS CNT
                            , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT
                            , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT
                        FROM
                        (
                            SELECT  
                                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호
                                , B.TAX_REG_NO AS TAX_REG_NO                    --사업자등록번호   
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액          
                            FROM FI_SLIP_LINE A
                                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
                            WHERE A.SOB_ID = W_SOB_ID
                                AND A.ORG_ID = W_ORG_ID 
                                
                                --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                                AND A.ACCOUNT_CODE IN 
                                    (
                                        SELECT ACCOUNT_CODE
                                        FROM FI_ACCOUNT_CONTROL
                                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                            AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                                    )  --거래구분(매입/매출)     
                                
                                AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
                                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                                AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                                AND REFER1 = '6'    --세무유형    
                                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
                        )
                        GROUP BY CARD_NUM, TAX_REG_NO
                        ORDER BY CARD_NUM, TAX_REG_NO    
                    )

                UNION ALL
        
                SELECT
                      '2' AS CARD_GB   --카드구분 : 현금영수증 거래자료라면 ‘2’
                    , ' ' AS CARD_NUM      --카드회원번호 : 카드구분이 ‘2’, ‘3’,‘4’이면 공란(Space)으로 채운다.
                    , ' ' AS TAX_REG_NO    --공급자(가맹점)사업자등록번호 : 카드구분이 ‘2’, ‘3’,‘4’이면 공란(Space)으로 채운다.
                    , COUNT(*) AS CNT  --매수
                    , NVL(SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))), 0) AS GL_AMOUNT     --공급가액
                    , NVL(SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))), 0) AS VAT_AMOUNT    --세액      
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    
                    --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                    AND A.ACCOUNT_CODE IN 
                        (
                            SELECT ACCOUNT_CODE
                            FROM FI_ACCOUNT_CONTROL
                            WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                        )  --거래구분(매입/매출)     
                    
                    AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                    AND REFER1 = '7'    --세무유형 : 현금영수증매입   
            )

        ) LOOP
        
            t_SEQ := REC_GET_OUTPUT.SEQ; --LOOP를 돌아 최종의 ROW COUNT를 담는다. 즉, DATA RECORD의 개수가 된다.
        
            INSERT_VAT_E_FILE('신용카드매출전표등수취명세서  매출전표 수취명세(Data Record)', REC_GET_OUTPUT.REC);

        END LOOP REC_GET_OUTPUT;   
        
    ELSE

        FOR REC_GET_OUTPUT IN (    

            SELECT
                 ROWNUM AS SEQ --일련번호 ; [신용카드등 매입내용 합계(Tail Record)] 명세서에서 사용함.
               , 'DL'  --1.레코드구분	CHAR	2
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.귀속년도	CHAR	4
            || RPAD(
                    CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                    END
               , 1, ' ') --3.반기구분	CHAR	1
            || RPAD(
                    CASE 
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                    END
               , 1, ' ') --4.반기내월순번	CHAR	1 
               
                || t_VAT_NUMBER_10                              --5.수취자(제출자)사업자등록번호	CHAR	10
                || CARD_GB                                      --6.카드구분	                    CHAR	1
                || RPAD(NVL(REPLACE(CARD_NUM, '-', ''), ' '), 20, ' ')    --7.카드회원번호	                CHAR	20
                || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.공급자(가맹점)사업자등록번호	CHAR	10
                || LPAD(CNT, 9, 0)                              --9.거래건수	                    NUMBER	9
                || RPAD(CASE WHEN GL_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --10.(공급가액)음수표시	CHAR	1
                || LPAD(GL_AMOUNT, 13, 0)                                           --11.공급가액	        NUMBER	13
                || RPAD(CASE WHEN VAT_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --12.(세액)음수표시	    CHAR	1
                || LPAD(VAT_AMOUNT, 13, 0)                                          --13.세액	            NUMBER	13
                || RPAD(' ', 54, ' ')   --14.공란	CHAR	54
                AS REC
            FROM
            (

                SELECT 
                    '1' AS CARD_GB   --카드구분 : 신용카드 및 직불카드 자료라면 ‘1’
                    , CARD_NUM      --카드회원번호
                    , TAX_REG_NO    --사업자등록번호
                    , CNT           --거래건수
                    , GL_AMOUNT     --공급가액
                    , VAT_AMOUNT    --세액
                FROM
                    (
                        SELECT        
                              CARD_NUM
                            , TAX_REG_NO
                            , COUNT(*) AS CNT
                            , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT
                            , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT
                        FROM
                        (
                            SELECT  
                                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호
                                , B.TAX_REG_NO AS TAX_REG_NO                    --사업자등록번호   
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액          
                            FROM FI_SLIP_LINE A
                                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
                            WHERE A.SOB_ID = W_SOB_ID
                                AND A.ORG_ID = W_ORG_ID 
                                
                                --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                                AND A.ACCOUNT_CODE IN 
                                    (
                                        SELECT ACCOUNT_CODE
                                        FROM FI_ACCOUNT_CONTROL
                                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                            AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                                    )  --거래구분(매입/매출)     
                                
                                AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
                                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
                                AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
                                AND REFER1 = '6'    --세무유형    
                                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
                        )
                        GROUP BY CARD_NUM, TAX_REG_NO
                        ORDER BY CARD_NUM, TAX_REG_NO    
                    )

            )

        ) LOOP
        
            t_SEQ := REC_GET_OUTPUT.SEQ; --LOOP를 돌아 최종의 ROW COUNT를 담는다. 즉, DATA RECORD의 개수가 된다.
        
            INSERT_VAT_E_FILE('신용카드매출전표등수취명세서  매출전표 수취명세(Data Record)', REC_GET_OUTPUT.REC);

        END LOOP REC_GET_OUTPUT;    
    
    END IF;
    
    






    --.서식명 : 신용카드등 매입내용 합계(Tail Record)   길이 : 140



    g_REPORT_CONTENT := NULL;
    
    SELECT    
           'TL'   --1.레코드구분	CHAR	2
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.귀속년도	CHAR	4
        || RPAD(
                CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
                END
           , 1, ' ') --3.반기구분	CHAR	1
        || RPAD(
                CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                END
           , 1, ' ') --4.반기내월순번	CHAR	1                             
        || t_VAT_NUMBER_10                      --5.수취자(제출자)사업자등록번호	CHAR	10

        || LPAD(t_SEQ, 7, 0)    --6.DATA건수	NUMBER	7
        || LPAD(COUNT(*), 9, 0) --7.거래건수    NUMBER	9
        || RPAD(CASE WHEN NVL(SUM(GL_AMOUNT), 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --8.(공급가액)음수표시	CHAR	1
        || LPAD(NVL(SUM(GL_AMOUNT), 0), 15, 0)                                           --9.공급가액	        NUMBER	15
        || RPAD(CASE WHEN NVL(SUM(VAT_AMOUNT), 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --10.(세액)음수표시	CHAR	1
        || LPAD(NVL(SUM(VAT_AMOUNT), 0), 15, 0)                                          --11.세액	            NUMBER	15
        
        || RPAD(' ', 74, ' ')   --12.공란	CHAR	74
        AS REC
    INTO g_REPORT_CONTENT
    FROM
    (
        SELECT
              REFER1    --세무유형  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)     
            
            AND A.MANAGEMENT2 = W_OPERATING_UNIT_ID     --사업장
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
            AND REFER1 IN ('6', '7')    --세무유형 : 카드매입, 현금영수증매입    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )   ;
        
    INSERT_VAT_E_FILE('신용카드매출전표등수취명세서(갑,을) 신용카드등 매입내용 합계(Tail Record)', g_REPORT_CONTENT);   

END IF; --IF t_E_FILE_GET_YN = 'Y' THEN           --전자신고파일생성대상여부_신용카드매출전표등수취명세서


















END CREATE_VAT_E_FILE;







--FI_VAT_E_FILE 자료 INSERT
PROCEDURE INSERT_VAT_E_FILE(
      P_REPORT_DOC      IN  FI_VAT_E_FILE.REPORT_DOC%TYPE       --신고서류명
    , P_REPORT_CONTENT  IN  FI_VAT_E_FILE.REPORT_CONTENT%TYPE   --신고내용   
)

AS

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , VAT_MAKE_GB	    --신고구분
        , SPEC_SERIAL	    --일련번호

        , REPORT_DOC        --신고서류명
        , REPORT_CONTENT    --신고내용
        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          g_SOB_ID              --회사아이디
        , g_ORG_ID              --사업부아이디
        , g_OPERATING_UNIT_ID   --사업장아이디
        , g_VAT_MNG_SERIAL      --부가세신고기간구분번호
        , '01'	                --신고구분
        , g_SPEC_SERIAL         --일련번호 

        , P_REPORT_DOC          --신고서류명
        , P_REPORT_CONTENT      --신고내용
        
        , g_SYSDATE     --생성일
        , g_CREATED_BY  --생성자
        , g_SYSDATE     --수정일
        , g_CREATED_BY  --수정자         
    FROM DUAL   ;

END INSERT_VAT_E_FILE;







--1-3. [부가가치세수입금액등(과세표준명세, 면세수입금액)] 자료 INSERT
--서식명 : 부가가치세 수입금액 등(일반,간이 공통), File : 부가가치세수입금액, 길이 : 150
PROCEDURE INSERT_1_4(
      W_AMT         IN  NUMBER      --금액
    , W_AMT_KIND    IN  VARCHAR2    --수입금액종류구분  
)

AS

BEGIN

    g_REPORT_CONTENT := NULL;

    SELECT
           '15'                 --1.자료구분	        CHAR	2	Not Null	[정기신고 : 15, 25]
        || 'V101'               --2.서식코드	        CHAR	4	Not Null	[일반 V101, 간이 V102 ]
        || W_AMT_KIND           --3.수입금액종류구분	CHAR	1   Not Null	[1,2,4,7,8,E]
        || g_BUSINESS_ITEM_30   --4.업태명              CHAR	30 
        || g_BUSINESS_TYPE_50   --5.종목명              CHAR	50
        || g_ATTRIBUTE1         --6.업종코드            CHAR	7
        || LPAD(REPLACE(LPAD(NVL(W_AMT, 0), 15, 0), '-', ''), 15, '-')    --7.수입금액	NUMBER	15
        || RPAD(' ', 41, ' ')   --8.공란	CHAR	41
    INTO g_REPORT_CONTENT
    FROM DUAL;

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , VAT_MAKE_GB	    --신고구분
        , SPEC_SERIAL	    --일련번호

        , REPORT_DOC        --신고서류명
        , REPORT_CONTENT    --신고내용
        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          g_SOB_ID  --회사아이디
        , g_ORG_ID  --사업부아이디
        , g_OPERATING_UNIT_ID       --사업장아이디
        , g_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , '01'	                    --신고구분
        , g_SPEC_SERIAL             --일련번호 

        , '부가가치세수입금액등(과세표준명세, 면세수입금액)'       --신고서류명
        , g_REPORT_CONTENT          --신고내용
        
        , g_SYSDATE     --생성일
        , g_CREATED_BY  --생성자
        , g_SYSDATE     --수정일
        , g_CREATED_BY  --수정자         
    FROM DUAL   ;

END INSERT_1_4;




--전자신고 파일 생성에 관련되는 부가세신고서 내역 조회
PROCEDURE LIST_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , OPERATING_UNIT_ID	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        --참조>수정신고는 처리할 수 있도록 틀만 만들고 실제 작업은 진행하지 않았다.
        , VAT_MAKE_GB	    --신고구분(01 : 정기신고, 02 : 수정신고)
        
        , GUBUN_1	--신고서구분_예정
        , GUBUN_2	--신고서구분_확정
        , GUBUN_3	--신고서구분_기한후과세표준
        , GUBUN_4	--신고서구분_영세율등조기환급                      
        , TITLE_2	--상호
        , TITLE_3	--성명        
        , TITLE_4	--사업자등록번호        
        , TITLE_5	--법인등록번호
        , TITLE_6	--사업장전화
        , TITLE_7	--주소지전화
        , TITLE_8	--휴대전화
        , TITLE_9	--사업장주소
        , TITLE_11	--업태
        , TITLE_12	--종목        
        , TITLE_13	--업종코드        

        , TITLE_1_1	        --신고기간_시작
        , TITLE_1_2	        --신고기간_종료
        , TITLE_14	        --작성일자
        , DEAL_BANK	        --거래은행
        , DEAL_BANK_CD	    --거래은행코드
        , DEAL_BRANCH	    --거래지점
        , DEAL_BRANCH_ID	--거래지점코드
        , ACC_NO	        --계좌번호
        , HOMETAX_USERID	--홈택스_사용자아이디
        , TITLE_10	        --전자우편주소
        
        , VAT_PRESENTER_GB  --제출자구분
        , FI_COMMON_G.CODE_NAME_F('VAT_PRESENTER_GB', VAT_PRESENTER_GB, SOB_ID, ORG_ID) AS VAT_PRESENTER_NM --제출자구분_명
        , VAT_LEVIER_GB	    --일반과세자구분
        , FI_COMMON_G.CODE_NAME_F('VAT_LEVIER_GB', VAT_LEVIER_GB, SOB_ID, ORG_ID) AS VAT_LEVIER_NM          --일반과세자구분_명
        , VAT_REFUND_GB	    --환급구분
        , FI_COMMON_G.CODE_NAME_F('VAT_REFUND_GB', VAT_REFUND_GB, SOB_ID, ORG_ID) AS VAT_REFUND_NM          --환급구분_명        
        
        --전자신고파일생성여부
        ,(        
            SELECT 
                CASE
                    WHEN COUNT(*) > 0 THEN 'Y'
                    ELSE 'N'
                END AS CREATE_YN
            FROM FI_VAT_E_FILE
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
                AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                AND VAT_MAKE_GB = '01' 
        ) AS CREATE_YN  

        , E_FILE_SURTAX_YN          --전자신고파일생성대상여부_부가세신고서
        , E_FILE_ZERO_YN            --전자신고파일생성대상여부_영세율첨부서류제출명세서
        , E_FILE_REAL_ESTATE_YN     --전자신고파일생성대상여부_부동산임대공급가액명세서
        , E_FILE_BLD_YN             --전자신고파일생성대상여부_건물등감가상각자산취득명세서
        , E_FILE_NO_DEDUCTION_YN    --전자신고파일생성대상여부_공제받지못할매입세액명세서        
        , E_FILE_TAX_PUB_YN         --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
        , E_FILE_DOMESTIC_LC_YN     --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서                 
        , E_FILE_SUM_VAT_YN         --전자시고파일생성대상여부_세금계산서합계표
        , E_FILE_SUM_CALC_YN        --전자신고파일생성대상여부_계산서합계표
        , E_FILE_EXPORT_YN          --전자신고파일생성대상여부_수출실적명세서
        , E_FILE_GET_YN             --전자신고파일생성대상여부_신용카드매출전표등수취명세서 
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = NVL(W_VAT_MAKE_GB, '01') --신고구분(01 : 정기신고)
    ;


END LIST_VAT_E_FILE;







--전자신고파일 생성에 필요한 부가세신고서 자료를 수정한다. ; 1번 째 탭 수정
PROCEDURE UPDATE_SURTAX_CARD(
      P_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --회사아이디
    , P_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --사업부아이디
    , P_OPERATING_UNIT_ID   IN  FI_SURTAX_CARD.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , P_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , P_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --일련번호    
    
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	        --작성일자
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	        --거래은행
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	    --거래은행코드
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	        --거래지점
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	    --거래지점코드
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	            --계좌번호
    , P_HOMETAX_USERID	    IN	FI_SURTAX_CARD.HOMETAX_USERID%TYPE	    --홈택스_사용자아이디
    , P_VAT_PRESENTER_GB	IN	FI_SURTAX_CARD.VAT_PRESENTER_GB%TYPE    --제출자구분
    , P_VAT_LEVIER_GB	    IN	FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE	    --일반과세자구분
    , P_VAT_REFUND_GB	    IN	FI_SURTAX_CARD.VAT_REFUND_GB%TYPE	    --환급구분
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	        --전자우편주소

    , P_E_FILE_SURTAX_YN	    IN  FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE        --전자신고파일생성대상여부_부가세신고서
    , P_E_FILE_ZERO_YN	        IN  FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE          --전자신고파일생성대상여부_영세율첨부서류제출명세서
    , P_E_FILE_REAL_ESTATE_YN   IN  FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE   --전자신고파일생성대상여부_부동산임대공급가액명세서
    , P_E_FILE_BLD_YN	        IN  FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE           --전자신고파일생성대상여부_건물등감가상각자산취득명세서
    , P_E_FILE_NO_DEDUCTION_YN	IN  FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE  --전자신고파일생성대상여부_공제받지못할매입세액명세서
    , P_E_FILE_SUM_VAT_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE       --전자시고파일생성대상여부_세금계산서합계표
    , P_E_FILE_SUM_CALC_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE      --전자신고파일생성대상여부_계산서합계표
    , P_E_FILE_EXPORT_YN	    IN  FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE        --전자신고파일생성대상여부_수출실적명세서
    , P_E_FILE_GET_YN	        IN  FI_SURTAX_CARD.E_FILE_GET_YN%TYPE           --전자신고파일생성대상여부_신용카드매출전표등수취명세서    
    , P_E_FILE_TAX_PUB_YN	    IN  FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE       --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
    , P_E_FILE_DOMESTIC_LC_YN   IN  FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서

    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    UPDATE FI_SURTAX_CARD
    SET
          TITLE_14	        = P_TITLE_14	        --작성일자
        , DEAL_BANK	        = P_DEAL_BANK	        --거래은행
        , DEAL_BANK_CD	    = P_DEAL_BANK_CD	    --거래은행코드
        , DEAL_BRANCH	    = P_DEAL_BRANCH	        --거래지점
        , DEAL_BRANCH_ID	= P_DEAL_BRANCH_ID	    --거래지점코드
        , ACC_NO	        = P_ACC_NO	            --계좌번호
        , HOMETAX_USERID	= P_HOMETAX_USERID	    --홈택스_사용자아이디
        , VAT_PRESENTER_GB	= P_VAT_PRESENTER_GB    --제출자구분
        , VAT_LEVIER_GB	    = P_VAT_LEVIER_GB	    --일반과세자구분
        , VAT_REFUND_GB	    = P_VAT_REFUND_GB	    --환급구분
        , TITLE_10	        = P_TITLE_10	        --전자우편주소

        , E_FILE_SURTAX_YN	        = P_E_FILE_SURTAX_YN        --전자신고파일생성대상여부_부가세신고서
        , E_FILE_ZERO_YN	        = P_E_FILE_ZERO_YN          --전자신고파일생성대상여부_영세율첨부서류제출명세서
        , E_FILE_REAL_ESTATE_YN     = P_E_FILE_REAL_ESTATE_YN   --전자신고파일생성대상여부_부동산임대공급가액명세서
        , E_FILE_BLD_YN	            = P_E_FILE_BLD_YN           --전자신고파일생성대상여부_건물등감가상각자산취득명세서
        , E_FILE_NO_DEDUCTION_YN    = P_E_FILE_NO_DEDUCTION_YN  --전자신고파일생성대상여부_공제받지못할매입세액명세서
        , E_FILE_SUM_VAT_YN	        = P_E_FILE_SUM_VAT_YN       --전자시고파일생성대상여부_세금계산서합계표
        , E_FILE_SUM_CALC_YN	    = P_E_FILE_SUM_CALC_YN      --전자신고파일생성대상여부_계산서합계표
        , E_FILE_EXPORT_YN	        = P_E_FILE_EXPORT_YN        --전자신고파일생성대상여부_수출실적명세서
        , E_FILE_GET_YN	            = P_E_FILE_GET_YN           --전자신고파일생성대상여부_신용카드매출전표등수취명세서        
        , E_FILE_TAX_PUB_YN	        = P_E_FILE_TAX_PUB_YN       --전자신고파일생성대상여부_전자세금계산서발급세액공제신고서
        , E_FILE_DOMESTIC_LC_YN     = P_E_FILE_DOMESTIC_LC_YN   --전자신고파일생성대상여부_내국신용장구매확인서전자발급명세서        

        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = P_SOB_ID                  --회사아이디
        AND ORG_ID                  = P_ORG_ID                  --사업부아이디
        AND OPERATING_UNIT_ID       = P_OPERATING_UNIT_ID       --사업장아이디        
        AND VAT_MNG_SERIAL          = P_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = P_SPEC_SERIAL             --일련번호
    ;

END UPDATE_SURTAX_CARD;









--전자신고파일 다운로드
PROCEDURE FILE_DOWN_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE  --사업부아이디
    , W_OPERATING_UNIT_ID   IN  FI_VAT_E_FILE.OPERATING_UNIT_ID%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE DEFAULT '01'    --신고구분(01 : 정기신고)
)

AS

t_CREATE_YN VARCHAR2(1);  --전자신고파일생성여부

BEGIN

/*
    --전자신고파일생성여부 
    BEGIN
    
        SELECT
            CASE
                WHEN COUNT(*) > 0 THEN 'Y'
                ELSE 'N'
            END AS CREATE_YN    
        INTO t_CREATE_YN
        FROM FI_VAT_E_FILE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
            AND VAT_MAKE_GB = '01'  ;
            
        --FCM_10387, 선택한 신고기간의 전자신고파일이 생성되어 있지 않습니다.
        IF t_CREATE_YN = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10387', NULL));
        END IF;            

    EXCEPTION
        WHEN OTHERS THEN
        --FCM_10387, 선택한 신고기간의 전자신고파일이 생성되어 있지 않습니다.
        IF t_CREATE_YN = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10387', NULL));
        END IF;
    
    END;
*/    

    OPEN P_CURSOR FOR

    SELECT 
          VAT_MNG_SERIAL  --부가세신고기간구분번호
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_MNG_NM  --신고기간구분_명
        , VAT_MAKE_GB   --신고구분
        , FI_COMMON_G.CODE_NAME_F('VAT_MAKE_GB', VAT_MAKE_GB, SOB_ID, ORG_ID) AS VAT_MAKE_NM    --신고구분_명
        , SPEC_SERIAL       --일련번호
        , REPORT_DOC        --신고서류명
        , REPORT_CONTENT    --신고내용  [전자신고파일내려받기 버튼 클릭했을 시는 본 칼럼만을 다운하여 파일로 저장한다.]
    FROM FI_VAT_E_FILE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND OPERATING_UNIT_ID = W_OPERATING_UNIT_ID
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01'
    ORDER BY SPEC_SERIAL    ;


END FILE_DOWN_VAT_E_FILE;








END FI_VAT_E_FILE_G;
/
