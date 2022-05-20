CREATE OR REPLACE PACKAGE FI_DPR_SPEC_G
AS

-- 감가상각자산 취득내역
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            );

-- 감가상각자산 취득내역 저장.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            );

-- 감가상각자산 취득내역 금액 리턴.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            );
            











--하기부터가 [건물등감가상각자산취득명세서] 프로그램에서 사용하기 위해 임동언이 작성한 프로시져 들이다.

--감가상각자산 취득내역 합계 : LIST_BUILDING_DPR_SPEC_MST
--감가상각자산 취득내역 명세 : LIST_BUILDING_DPR_SPEC_DET
--저장 : UPDATE_BUILDING_DPR_SPEC
--건물등감가상각자산취득명세서 상단 출력용 : PRINT_BUILDING_DPR_SPEC_TITLE




--감가상각자산 취득내역 합계
PROCEDURE LIST_BUILDING_DPR_SPEC_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE        IN  VARCHAR2                 --사업장(예>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --신고기간_시작
    , W_ISSUE_DATE_TO   IN  DATE                     --신고기간_종료
);






--감가상각자산 취득내역 명세
PROCEDURE LIST_BUILDING_DPR_SPEC_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE        IN  VARCHAR2                 --사업장(예>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --신고기간_시작
    , W_ISSUE_DATE_TO   IN  DATE                     --신고기간_종료
);





--감가상각자산 취득내역 수정 및 전표상세 자료(REFER10 : 고정자산과표, REFER11 : 고정자산세액) 수정
PROCEDURE UPDATE_BUILDING_DPR_SPEC( 
      P_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE             --회사아이디
    , P_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE             --사업부아이디
    , P_SLIP_LINE_ID    IN  FI_DPR_SPEC.SLIP_LINE_ID%TYPE       --전표라인아이디
    , P_DPR_ASSET_GB_ID IN  FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE    --건물등감가상각취득명세서_자산구분
    , P_SPEC_CONTENTS   IN  FI_DPR_SPEC.SPEC_CONTENTS%TYPE      --품명및내역
    , P_SUP_AMOUNT      IN  FI_DPR_SPEC.SUP_AMOUNT%TYPE         --공급가액
    , P_SURTAX          IN  FI_DPR_SPEC.SURTAX%TYPE             --부가세
    , P_ASSET_CNT       IN  FI_DPR_SPEC.ASSET_CNT%TYPE          --자산건수
    , P_LAST_UPDATED_BY IN  FI_DPR_SPEC.LAST_UPDATED_BY%TYPE    --수정자
);






--건물등감가상각자산취득명세서 상단 출력용
PROCEDURE PRINT_BUILDING_DPR_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  NUMBER                --회사아이디
    , W_ORG_ID                  IN  NUMBER                --사업부아이디
    , W_TAX_CODE                IN  VARCHAR2              --사업장아이디(예>42) ; 사용안하는데 취지상 맞기에 빼지는 안는다.  
    
    --아래 항목은 출력시 필수항목이다.
    , W_DEAL_DATE_FR            IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO            IN  DATE    --신고기간_종료
    , W_CREATE_DATE             IN  DATE    --작성일자
);




            
END FI_DPR_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_SPEC_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DPR_SPEC_G
/* Description  : 감가상각자산 취득내역.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 감가상각자산 취득내역
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DAG.DPR_ASSET_GB_NAME
           , FDS.SPEC_CONTENTS
           , FDS.SUP_AMOUNT
           , FDS.SURTAX
           , FDS.ASSET_CNT
           , DAG.DPR_ASSET_GB_ID
           , NVL(FDS.SLIP_LINE_ID, W_SLIP_LINE_ID) AS SLIP_LINE_ID
        FROM FI_DPR_ASSET_GB_V DAG
          , ( SELECT DS.SOB_ID
                   , DS.SLIP_LINE_ID
                   , DS.DPR_ASSET_GB_ID
                   , DS.SPEC_CONTENTS
                   , DS.SUP_AMOUNT
                   , DS.SURTAX
                   , DS.ASSET_CNT
                FROM FI_DPR_SPEC DS
              WHERE DS.SOB_ID           = W_SOB_ID
                AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
            ) FDS
      WHERE DAG.DPR_ASSET_GB_ID         = FDS.DPR_ASSET_GB_ID(+)
        AND DAG.SOB_ID                  = FDS.SOB_ID(+)
        AND DAG.SOB_ID                  = W_SOB_ID
      ORDER BY DAG.DPR_ASSET_GB
      ;
  END SELECT_DPR_ASSET;

-- 감가상각자산 취득내역 저장.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
   IF P_SPEC_CONTENTS IS NULL AND NVL(P_SUP_AMOUNT, -1) = -1 AND NVL(P_SURTAX, -1) = -1 AND NVL(P_ASSET_CNT, -1) = -1 THEN
      DELETE FROM FI_DPR_SPEC DS
      WHERE DS.SLIP_LINE_ID     = P_SLIP_LINE_ID
        AND DS.DPR_ASSET_GB_ID  = P_DPR_ASSET_GB_ID
        AND DS.SOB_ID           = P_SOB_ID
      ;    
    ELSE      
      UPDATE FI_DPR_SPEC DS
        SET DS.SPEC_CONTENTS    = P_SPEC_CONTENTS
          , DS.SUP_AMOUNT       = NVL(P_SUP_AMOUNT, 0)
          , DS.SURTAX           = NVL(P_SURTAX, 0)
          , DS.ASSET_CNT        = NVL(P_ASSET_CNT, 0)
          , DS.LAST_UPDATE_DATE = V_SYSDATE
          , DS.LAST_UPDATED_BY  = P_USER_ID
      WHERE DS.SLIP_LINE_ID     = P_SLIP_LINE_ID
        AND DS.DPR_ASSET_GB_ID  = P_DPR_ASSET_GB_ID
        AND DS.SOB_ID           = P_SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_DPR_SPEC
        ( SOB_ID
        , ORG_ID 
        , SLIP_LINE_ID 
        , DPR_ASSET_GB_ID 
        , SPEC_CONTENTS 
        , SUP_AMOUNT 
        , SURTAX 
        , ASSET_CNT 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY      
        ) VALUES
        ( P_SOB_ID
        , P_ORG_ID
        , P_SLIP_LINE_ID
        , P_DPR_ASSET_GB_ID
        , P_SPEC_CONTENTS
        , NVL(P_SUP_AMOUNT, 0)
        , NVL(P_SURTAX, 0)
        , NVL(P_ASSET_CNT, 0)
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END IF;
  END SAVE_DPR_SPEC;

-- 감가상각자산 취득내역 금액 리턴.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT NVL(SUM(DS.SUP_AMOUNT), 0) AS SUP_AMOUNT
           , NVL(SUM(DS.SURTAX), 0) AS SURTAX
        INTO O_SUP_AMOUNT
           , O_SURTAX
        FROM FI_DPR_SPEC DS
      WHERE DS.SOB_ID           = W_SOB_ID
        AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_SUP_AMOUNT := 0;
      O_SURTAX := 0;
    END;
  END DPR_ASSET_AMOUNT_P;




















--하기부터가 [건물등감가상각자산취득명세서] 프로그램에서 사용하기 위해 임동언이 작성한 프로시져 들이다.

--감가상각자산 취득내역 합계 : LIST_BUILDING_DPR_SPEC_MST
--감가상각자산 취득내역 명세 : LIST_BUILDING_DPR_SPEC_DET
--저장 : UPDATE_BUILDING_DPR_SPEC
--건물등감가상각자산취득명세서 상단 출력용 : PRINT_BUILDING_DPR_SPEC_TITLE



--감가상각자산 취득내역 합계
PROCEDURE LIST_BUILDING_DPR_SPEC_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE        IN  VARCHAR2                 --사업장(예>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --신고기간_시작
    , W_ISSUE_DATE_TO   IN  DATE                     --신고기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          9 AS DPR_ASSET_GB_ID  --[9]는 UNION ALL 의 조건을 충족하기 위해 임의의 숫자를 준 것으로 별다른 의미 없다.
        , 5 AS SEQ   --명세서의 감가상각자산종류 번호
        , ' 합                      계' AS DPR_ASSET_GB   --감가상각자산종류
        , TO_NUMBER(DECODE(SUM(ASSET_CNT), 0, NULL, SUM(ASSET_CNT))) AS ASSET_CNT       --건수
        , TO_NUMBER(DECODE(SUM(SUP_AMOUNT), 0, NULL, SUM(SUP_AMOUNT))) AS SUP_AMOUNT    --공급가액
        , TO_NUMBER(DECODE(SUM(SURTAX), 0, NULL, SUM(SURTAX))) AS SURTAX                --부가세         
        , '' AS REMARKS                 --비고
    --FROM / WHERE 절은 [감가상각자산 취득내역 명세 PROCEDURE] 절의 내용과 100% 같다.
    FROM FI_DPR_SPEC A
        , FI_SLIP_LINE B
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --거래처
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID     
        AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
        AND B.MANAGEMENT2 = W_TAX_CODE --사업장
        AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
        AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자

    UNION ALL

    SELECT
          A.DPR_ASSET_GB_ID
        , DECODE(A.DPR_ASSET_GB_ID, '1669', 6, '1670', 7, '1671', 8, '1672', 9) AS SEQ   --명세서의 감가상각자산종류 번호
        , A.DPR_ASSET_GB    --감가상각자산종류
        , TO_NUMBER(DECODE(B.ASSET_CNT, 0, NULL, B.ASSET_CNT)) AS ASSET_CNT     --건수
        , TO_NUMBER(DECODE(B.SUP_AMOUNT, 0, NULL, B.SUP_AMOUNT)) AS SUP_AMOUNT  --공급가액
        , TO_NUMBER(DECODE(B.SURTAX, 0, NULL, B.SURTAX)) AS SURTAX              --부가세
        , '' AS REMARKS --비고
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
                , SUM(ASSET_CNT) AS ASSET_CNT   --건수
                , SUM(SUP_AMOUNT) AS SUP_AMOUNT --공급가액
                , SUM(SURTAX) AS SURTAX         --부가세
            --FROM / WHERE 절은 [감가상각자산 취득내역 명세 PROCEDURE] 절의 내용과 100% 같다.
            FROM FI_DPR_SPEC A
                , FI_SLIP_LINE B
                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --거래처
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID     
                AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
                AND B.MANAGEMENT2 = W_TAX_CODE --사업장
                AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
                AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자                               
            GROUP BY DPR_ASSET_GB_ID
        ) B
    WHERE A.DPR_ASSET_GB_ID = B.DPR_ASSET_GB_ID(+)
    ORDER BY DPR_ASSET_GB_ID    ;


END LIST_BUILDING_DPR_SPEC_MST;








--감가상각자산 취득내역 명세
PROCEDURE LIST_BUILDING_DPR_SPEC_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE        IN  VARCHAR2                 --사업장(예>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --신고기간_시작
    , W_ISSUE_DATE_TO   IN  DATE                     --신고기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID          --회사아이디
        , A.ORG_ID          --사업부아이디
        , A.SLIP_LINE_ID    --전표라인아이디    
        , A.DPR_ASSET_GB_ID --건물등감가상각취득명세서_자산구분아이디
        
        , FI_COMMON_G.ID_NAME_F(A.DPR_ASSET_GB_ID) AS DPR_ASSET_GB  --건물등감가상각취득명세서_자산구분
        , B.REFER2 AS VAT_ISSUE_DATE        --공급받은일자; 신고기준일자
        , B.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
        , C.SUPP_CUST_NAME AS SUPPLIER_NAME --거래처명
        , C.TAX_REG_NO AS TAX_REG_NO        --사업자번호
        , A.SPEC_CONTENTS   --품명및내역
        , A.SUP_AMOUNT      --공급가액
        , A.SURTAX          --부가세
        , A.ASSET_CNT       --건수
    --FROM / WHERE 절은 [감가상각자산 취득내역 합계 PROCEDURE] 절의 내용과 100% 같다.    
    FROM FI_DPR_SPEC A
        , FI_SLIP_LINE B
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --거래처
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID     
        AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
        AND B.MANAGEMENT2 = W_TAX_CODE --사업장
        AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
        AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --신고기준일자 
    ORDER BY VAT_ISSUE_DATE, DPR_ASSET_GB_ID    ;
    
       
END LIST_BUILDING_DPR_SPEC_DET;







--감가상각자산 취득내역 수정 및 전표상세 자료(REFER10 : 고정자산과표, REFER11 : 고정자산세액) 수정
PROCEDURE UPDATE_BUILDING_DPR_SPEC( 
      P_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE             --회사아이디
    , P_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE             --사업부아이디
    , P_SLIP_LINE_ID    IN  FI_DPR_SPEC.SLIP_LINE_ID%TYPE       --전표라인아이디
    , P_DPR_ASSET_GB_ID IN  FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE    --건물등감가상각취득명세서_자산구분
    , P_SPEC_CONTENTS   IN  FI_DPR_SPEC.SPEC_CONTENTS%TYPE      --품명및내역
    , P_SUP_AMOUNT      IN  FI_DPR_SPEC.SUP_AMOUNT%TYPE         --공급가액
    , P_SURTAX          IN  FI_DPR_SPEC.SURTAX%TYPE             --부가세
    , P_ASSET_CNT       IN  FI_DPR_SPEC.ASSET_CNT%TYPE          --자산건수
    , P_LAST_UPDATED_BY IN  FI_DPR_SPEC.LAST_UPDATED_BY%TYPE    --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN
 
    --1.FI_DPR_SPEC
    UPDATE FI_DPR_SPEC
    SET 
          SPEC_CONTENTS = P_SPEC_CONTENTS   --품명및내역
        , SUP_AMOUNT    = P_SUP_AMOUNT      --공급가액
        , SURTAX        = P_SURTAX          --부가세
        , ASSET_CNT     = P_ASSET_CNT       --자산건수
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID
        AND SLIP_LINE_ID = P_SLIP_LINE_ID
        AND DPR_ASSET_GB_ID = P_DPR_ASSET_GB_ID ;   



    --2.FI_SLIP_LINE

    --REFER10 : 고정자산과표, REFER11 : 고정자산세액
    UPDATE FI_SLIP_LINE
    SET (REFER10, REFER11) = 
        (
            SELECT SUM(SUP_AMOUNT), SUM(SURTAX)
            FROM FI_DPR_SPEC
            WHERE SOB_ID = P_SOB_ID
                AND ORG_ID = P_ORG_ID
                AND SLIP_LINE_ID = P_SLIP_LINE_ID
        )
    WHERE SLIP_LINE_ID = P_SLIP_LINE_ID ;



END UPDATE_BUILDING_DPR_SPEC;






--건물등감가상각자산취득명세서 상단 출력용
PROCEDURE PRINT_BUILDING_DPR_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  NUMBER                --회사아이디
    , W_ORG_ID                  IN  NUMBER                --사업부아이디
    , W_TAX_CODE                IN  VARCHAR2              --사업장아이디(예>42) ; 사용안하는데 취지상 맞기에 빼지는 안는다.  
    
    --아래 항목은 출력시 필수항목이다.
    , W_DEAL_DATE_FR            IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO            IN  DATE    --신고기간_종료
    , W_CREATE_DATE             IN  DATE    --작성일자
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --사업자등록번호
        , A.CORP_NAME                           --상호(법인명)
        , A.PRESIDENT_NAME                      --성명(대표자)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --사업장소재지
        , A.TEL_NUMBER                          --전화번호
        --, B.ADDR1 || ' ' || B.ADDR2 || ' (  ' || A.TEL_NUMBER || '  ) ' AS LOCATION_TEL  --사업장소재지(전화번호)
        , B.BUSINESS_ITEM    --업태
        , B.BUSINESS_TYPE    --종목        
        --, B.BUSINESS_ITEM || '(' || B.BUSINESS_TYPE || ')' AS BUSINESS    --업태(종목) 
        , B.TAX_OFFICE_NAME --관할세무서

        --, TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --작성일자
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || ' 년   ' ||
          TO_CHAR(W_CREATE_DATE, 'MM') || ' 월   ' ||
          TO_CHAR(W_CREATE_DATE, 'DD') || ' 일'  AS CREATE_DATE  --작성일자
          
        --, TO_CHAR(W_DEAL_DATE_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY.MM.DD') AS DEAL_TERM    --신고기간                      
        , TO_CHAR(W_DEAL_DATE_TO, 'YYYY')  || ' 년   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1 기   (  '
            ELSE '2 기   (  '
          END
          || TO_CHAR(W_DEAL_DATE_FR, 'MM') || ' 월  ' || TO_CHAR(W_DEAL_DATE_FR, 'DD')  || ' 일  ~  '
          || TO_CHAR(W_DEAL_DATE_TO, 'MM') || ' 월  ' || TO_CHAR(W_DEAL_DATE_TO, 'DD') || ' 일  )'
          AS FISCAL_YEAR   --부가가치세신고기수             
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
        
END PRINT_BUILDING_DPR_SPEC_TITLE;






  
END FI_DPR_SPEC_G;
/
