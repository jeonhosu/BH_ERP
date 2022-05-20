CREATE OR REPLACE PACKAGE FI_ASSET_DPR_HISTORY_CG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ASSET_DPR_HISTORY_CG_G
Description  : 감가상각전표생성 Package

Reference by : calling assmbly-program id(호출 프로그램) : (감가상각전표생성)
Program History :
    자산대장관리에 의해 생성된 각 자산별 상각스케쥴자료를 바탕으로 프로그램에서
    작업자가 선택한 자료에 대해 자동전표분개유형관리 프로그램의 자료를 참조해 자동전표를 생성한다.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-31   Leem Dong Ern(임동언)
*****************************************************************************/





--감가상각스케쥴자료 조회
PROCEDURE LIST_ASSET_DPR_HISTORY(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --자산유형아이디          
);




--전표생성 버튼을 클릭하면 아래 2개의 PROCEDURE가 실행된다.
--1.UPDATE_ASSET_DPR_HISTORY
--2.CREATE_DPR_SLIP (전표유형 : DPR - 감가상각전표)


--작업자에 의해 전표로 생성하기 위해 선택된 자료들에 대해 전표생성여부[SLIP_YN] 칼럼의 값을 'Y'로 수정한다.
--전표생성 대상자료는 전표생성여부[SLIP_YN] 칼럼이 'Y'이고 상각여부[DPR_YN]가 'Y'가 아닌 자료이다.
PROCEDURE UPDATE_ASSET_DPR_HISTORY(
      W_SOB_ID      IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE        --회사아이디
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE        --사업부아이디
    , W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY_CG.DPR_TYPE%TYPE      --회계구분[20 : IFRS]
    , W_PERIOD_NAME IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE   --상각년월
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY_CG.ASSET_ID%TYPE      --자산아이디
    , P_SLIP_YN     IN  FI_ASSET_DPR_HISTORY_CG.SLIP_YN%TYPE       --전표생성여부
    , P_DPR_YN      IN  FI_ASSET_DPR_HISTORY_CG.DPR_YN%TYPE        --상각여부
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --최종수정자
);





--전표생성
PROCEDURE CREATE_DPR_SLIP( 
      W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_ID%TYPE    --자산유형아이디
    , W_ASSET_CATEGORY_CODE IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE  --자산유형코드
    , P_USER_ID             IN  FI_ASSET_DPR_HISTORY_CG.CREATED_BY%TYPE        --생성자
    
    , O_MESSAGE             OUT VARCHAR2    --전표생성 후 화면으로 작업 결과 반환함.
);





--전표삭제 : 선택한 전표를 삭제한다.
PROCEDURE DELETE_DPR_SLIP( 
      W_SOB_ID          IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME     IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , P_SLIP_HEADER_ID  IN  FI_ASSET_DPR_HISTORY_CG.SLIP_HEADER_ID%TYPE    --전표헤더ID
    , P_GL_NUM          IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE            --전표번호
    , P_USER_ID         IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --최종수정자
    
    , O_MESSAGE         OUT VARCHAR2    --전표삭제 후 화면으로 작업 결과 반환함.
);






--전표별상각자산 조회
PROCEDURE LIST_SLIP_DPR(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디 
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --자산유형아이디      
);





--전표별분개자료 조회
PROCEDURE LIST_SLIP_JOURNAL(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --사업부아이디
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --전표번호       
);






--전표별자산원장 조회
PROCEDURE LIST_SLIP_ASSET(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --사업부아이디
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --전표번호
);



END FI_ASSET_DPR_HISTORY_CG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_DPR_HISTORY_CG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ASSET_DPR_HISTORY_CG_G
Description  : 감가상각전표생성 Package

Reference by : calling assmbly-program id(호출 프로그램) : (감가상각전표생성)
Program History :
    자산대장관리에 의해 생성된 각 자산별 상각스케쥴자료를 바탕으로 프로그램에서
    작업자가 선택한 자료에 대해 자동전표분개유형관리 프로그램의 자료를 참조해 자동전표를 생성한다.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-31   Leem Dong Ern(임동언)
*****************************************************************************/







--감가상각스케쥴자료 조회
PROCEDURE LIST_ASSET_DPR_HISTORY(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --자산유형아이디          
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --회사아이디
        , A.ORG_ID              --사업부아이디
        , DECODE(A.SLIP_YN, 'Y', 'Y', 'N') AS SLIP_YN        --전표생성여부        
        , A.PERIOD_NAME         --상각년월    
        , A.ASSET_CATEGORY_ID   --자산유형아이디
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --자산유형
        , B.EXPENSE_TYPE    --경비구분
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --경비구분     
        , A.COST_CENTER_ID  --원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명      
        , A.ASSET_ID                            --자산아이디
        , B.ASSET_CODE                          --자산코드
        , B.ASSET_DESC                          --자산명    
        , NVL(A.DPR_YN, 'N') AS DPR_YN          --(감가)상각여부    
        , A.DPR_COUNT                           --상각회차    
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(최종)감가상각비   
        , A.SLIP_DATE       --전표일자
        , A.GL_NUM          --전표번호
        , A.SLIP_HEADER_ID  --전표헤더ID
        , (SELECT REMARK FROM FI_SLIP_HEADER WHERE GL_NUM = A.GL_NUM) AS GL_REMARK --전표적요
        
        , A.DPR_TYPE    --회계구분_코드[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --회계구분
        , A.DPR_METHOD_TYPE --감가상각방법_코드
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --감가상각방법          
    FROM FI_ASSET_DPR_HISTORY_CG A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER_CG
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND IFRS_DPR_STATUS_CODE != '90'   --(IFRS)상각상태; 상각이 완료되지 않은 자료만
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --회계구분[20 : IFRS]
        AND A.ASSET_ID = B.ASSET_ID

        AND A.PERIOD_NAME = W_PERIOD_NAME
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID    --예>21:기계장치
        AND A.GL_NUM IS NULL    --전표생성이 되지 않은 자료만 조회한다.
    ORDER BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID, B.ASSET_CODE    ;

END LIST_ASSET_DPR_HISTORY;






--전표생성 버튼을 클릭하면 아래 2개의 PROCEDURE가 실행된다.
--1.UPDATE_ASSET_DPR_HISTORY
--2.CREATE_DPR_SLIP (전표유형 : DPR - 감가상각전표)




--작업자에 의해 전표로 생성하기 위해 선택된 자료들에 대해 전표생성여부[SLIP_YN] 칼럼의 값을 'Y'로 수정한다.
--전표생성 대상자료는 전표생성여부[SLIP_YN] 칼럼이 'Y'이고 상각여부[DPR_YN]가 'Y'가 아닌 자료이다.
PROCEDURE UPDATE_ASSET_DPR_HISTORY(
      W_SOB_ID      IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE        --회사아이디
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE        --사업부아이디
    , W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY_CG.DPR_TYPE%TYPE      --회계구분[20 : IFRS]
    , W_PERIOD_NAME IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE   --상각년월
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY_CG.ASSET_ID%TYPE      --자산아이디
    , P_SLIP_YN     IN  FI_ASSET_DPR_HISTORY_CG.SLIP_YN%TYPE       --전표생성여부
    , P_DPR_YN      IN  FI_ASSET_DPR_HISTORY_CG.DPR_YN%TYPE        --상각여부
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --최종수정자    
)

AS

BEGIN

    --전표생성여부가 Y이고 상각여부가 Y가 아닌 자료에 대해 변경한다.
    IF P_SLIP_YN = 'Y' AND P_DPR_YN != 'Y' THEN

        UPDATE FI_ASSET_DPR_HISTORY_CG
        SET       SLIP_YN               = P_SLIP_YN         --전표생성여부
            
            , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)    --최종수정일자
            , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         --최종수정자
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND DPR_TYPE = W_DPR_TYPE
            AND PERIOD_NAME = W_PERIOD_NAME
            AND ASSET_ID = W_ASSET_ID ;

    END IF;

END UPDATE_ASSET_DPR_HISTORY;







--전표생성
PROCEDURE CREATE_DPR_SLIP( 
      W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_ID%TYPE    --자산유형아이디    
    , W_ASSET_CATEGORY_CODE IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE  --자산유형코드    
    , P_USER_ID             IN  FI_ASSET_DPR_HISTORY_CG.CREATED_BY%TYPE        --생성자
    
    , O_MESSAGE             OUT VARCHAR2    --전표생성 후 화면으로 작업 결과 반환함.
)

AS

t_SLIP_CREATE_CNT   NUMBER := 0;  --전표생성할 자료 존재유무를 파악한다.
t_DEPT_ID           FI_SLIP_LINE.DEPT_ID%TYPE;              --전표작성부서
t_SLIP_DATE         FI_SLIP_LINE.SLIP_DATE%TYPE;            --전표일자 : 해당월 말일자.
t_SLIP_NUM          FI_SLIP_LINE.SLIP_NUM%TYPE;             --(채번된)전표번호
t_CURRENCY_CODE     FI_SLIP_LINE.CURRENCY_CODE%TYPE;        --기본통화
t_SLIP_TYPE         FI_SLIP_LINE.SLIP_TYPE%TYPE := 'DPR';   --전표유형(DPR : 감가상각)

t_SLIP_REMARKS_HEADER   FI_AUTO_JOURNAL_MST.SLIP_REMARKS%TYPE;  --헤더전표적요

t_JOB_CATEGORY_CD   FI_COMMON.CODE%TYPE;  --공통코드; 업무분류코드

V_SLIP_HEADER_ID    FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;       --전표헤더아이디

--이 변수는 사용안하지만, 기존 PROCEDURE를 이용하기 위해 선언했을 뿐이다.
t_SLIP_LINE_ID      FI_SLIP_LINE.SLIP_LINE_ID%TYPE;         --전표라인ID

t_CREATED_TYPE      FI_SLIP_HEADER.CREATED_TYPE%TYPE := 'I';                    --생성구분(M:메뉴얼, I:INTERFACE)
t_SOURCE_TABLE      FI_SLIP_HEADER.SOURCE_TABLE%TYPE := 'FI_ASSET_DPR_HISTORY_CG'; --INTERFACE 소스테이블

--EXPENSE_TYPE(경비구분)  [10:판관, 20:제조]
t_ACCOUNT_CONTROL_ID_10 FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --계정통제ID
t_ACCOUNT_CODE_10       FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --계정코드
t_SLIP_REMARKS_10       FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --전표적요
t_ACCOUNT_CONTROL_ID_20 FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --계정통제ID
t_ACCOUNT_CODE_20       FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --계정코드
t_SLIP_REMARKS_20       FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --전표적요
t_ACCOUNT_CONTROL_ID    FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --계정통제ID
t_ACCOUNT_CODE          FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --계정코드
t_SLIP_REMARKS_LINE     FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --전표적요

t_GL_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE;         --전표금액

V_SYSDATE               DATE := GET_LOCAL_DATE(W_SOB_ID);   --수정일자


BEGIN

    --전표생성할 자료 존재유무를 파악한다.
    --전표생성여부가 Y이고 상각여부가 Y가 아닌 자료의 존재 여부를 파악한다.
    SELECT COUNT(*)
    INTO t_SLIP_CREATE_CNT
    FROM FI_ASSET_DPR_HISTORY_CG
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND DPR_TYPE = '20'   --회계구분[20 : IFRS]
        AND PERIOD_NAME = W_PERIOD_NAME
        AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
        AND SLIP_YN = 'Y'
        AND NVL(DPR_YN, 'N') != 'Y'   ;
        
    IF t_SLIP_CREATE_CNT = 0 THEN
        --FCM_10381 : 자동전표 생성할 자료가 존재하지 않습니다. 확인하세요.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10381', NULL));        
    END IF;  


    --전표작성부서 추출    
    BEGIN
        --아래의 SELECT문구는 마음에 들지는 않지만 기존에 있는 QUERY를 그대로 사용했다.
        /* 본 주석블럭의 SQL은 전과장이 작성한 것인데 이것으로 할 경우 발의부서를 못찾는 현상이 발생해
           하단의 SQL로 대체한다. 
           하단의 SQL도 전과장이 다른 프로그램에서 자동전표 생성 시 사용했던 SQL이다.
           이 SQL을 전과장이 작성한 것에 의존하는 이유는 내가 모든 설계 사상을 모르기 때문에
           본 회계 모듈을 설계한 전과장이 작성한 SQL이 맞다고 전제하고 사용하는 것일 뿐이다.
       */
       
       
        
        SELECT FDM.DEPT_ID
        INTO t_DEPT_ID
        FROM HRM_PERSON_MASTER PM
            , HRM_DEPT_MASTER HDM
            , FI_DEPT_MASTER_MAPPING_V FDM
        WHERE PM.DEPT_ID = HDM.DEPT_ID
            AND HDM.DEPT_ID = FDM.HR_DEPT_ID(+)
            AND HDM.CORP_ID = FDM.HR_CORP_ID(+)
            AND HDM.SOB_ID = FDM.SOB_ID(+)
            AND PM.PERSON_ID = P_USER_ID
            AND PM.SOB_ID = W_SOB_ID   ;
           
        
        
        /*
        SELECT DM.M_DEPT_ID
        INTO t_DEPT_ID
        FROM EAPP_USER EU
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
        WHERE EU.PERSON_ID  = PM.PERSON_ID(+)
        AND PM.DEPT_ID      = DM.HR_DEPT_ID(+)
        AND EU.USER_ID      = P_USER_ID
        AND EU.SOB_ID       = W_SOB_ID
        ;
        */
            
        EXCEPTION WHEN OTHERS THEN
            --FCM_10183 : 발의부서 정보를 찾지 못했습니다. 확인하세요.
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL));
    END;



    BEGIN

        t_SLIP_DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));                             --전표일자
        t_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', W_SOB_ID, t_SLIP_DATE, P_USER_ID); --(채번된)전표번호
        t_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);                         --기본통화

        --업무분류코드
        SELECT CODE
        INTO t_JOB_CATEGORY_CD
        FROM FI_COMMON
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND GROUP_CODE = 'JOB_CATEGORY' --업무분류
            AND VALUE3 = W_ASSET_CATEGORY_CODE  ;      
                
        
        --FI_SLIP_HEADER(전표헤더) 테이블에 설정될 전표적요를 추출한다.
        SELECT SLIP_REMARKS
        INTO t_SLIP_REMARKS_HEADER
        FROM FI_AUTO_JOURNAL_MST
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE_CD = t_SLIP_TYPE    --(DPR : 감가상각)
            AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD   ;
                    

        --FI_SLIP_HEADER TABLE INSERT
        --아래 PROCEDURE실행결과 V_SLIP_HEADER_ID(전표헤더아이디)를 RETURN 받으며, 
        --이 값은 FI_SLIP_LINE TABLE INSERT 시에 사용된다.
        FI_SLIP_G.INSERT_SLIP_HEADER(
              V_SLIP_HEADER_ID      --전표헤더아이디
            , t_SLIP_DATE           --전표일자
            , t_SLIP_NUM            --전표번호
            , W_SOB_ID              --회사아이디
            , W_ORG_ID              --사업부아이디
            , t_DEPT_ID             --발의부서
            , P_USER_ID             --발의자
            , NULL                  --예산부서
            , t_SLIP_TYPE           --전표유형
            , t_SLIP_DATE           --회계일자; 전표일자와 동일한 값으로 설정한다.
            , t_SLIP_NUM            --회계번호; 전표번호와 동일한 값으로 설정한다.
            , NULL                  --공급사 은행계좌
            , NULL                  --지급 요청방법(현금, 어음...)
            , NULL                  --지급 요청일
            , t_SLIP_REMARKS_HEADER --적요
            , P_USER_ID             --생성자
            , t_CREATED_TYPE        --생성구분(M:메뉴얼, I:INTERFACE)
            , t_SOURCE_TABLE        --INTERFACE 소스테이블
            , NULL                  --INTERFACE 소스 HEADER ID
        );
        
        
        
        
        
        --FI_SLIP_LINE(전표상세) 테이블에 INSERT할 시 차변 계정관련 필요정보 추출
        --자료는 2건으로 감가상각비 제조/판관비이다.
        FOR REC_EXPENSE_ACCOUNT IN (
            SELECT
                  DECODE(SUBSTR(ACCOUNT_CODE, 1, 2), '51', '20', '52', '10') AS EXPENSE_TYPE  --경비구분[10:판관, 20:제조]
                , ACCOUNT_CONTROL_ID    --계정통제ID    
                , ACCOUNT_CODE          --계정코드
                , SLIP_REMARKS          --전표적요
            FROM FI_AUTO_JOURNAL_DET
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE_CD = 'DPR'
                AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD
                AND ACCOUNT_DR_CR = '1' --1:차변, 2:대변        
        ) LOOP
            --EXPENSE_TYPE(경비구분)  [10:판관, 20:제조]
            IF REC_EXPENSE_ACCOUNT.EXPENSE_TYPE = '10' THEN
                t_ACCOUNT_CONTROL_ID_10 := REC_EXPENSE_ACCOUNT.ACCOUNT_CONTROL_ID;    --계정통제ID
                t_ACCOUNT_CODE_10       := REC_EXPENSE_ACCOUNT.ACCOUNT_CODE;          --계정코드
                t_SLIP_REMARKS_10       := REC_EXPENSE_ACCOUNT.SLIP_REMARKS;          --전표적요          
            ELSIF REC_EXPENSE_ACCOUNT.EXPENSE_TYPE = '20' THEN
                t_ACCOUNT_CONTROL_ID_20 := REC_EXPENSE_ACCOUNT.ACCOUNT_CONTROL_ID;    --계정통제ID
                t_ACCOUNT_CODE_20       := REC_EXPENSE_ACCOUNT.ACCOUNT_CODE;          --계정코드
                t_SLIP_REMARKS_20       := REC_EXPENSE_ACCOUNT.SLIP_REMARKS;          --전표적요              
            END IF;
        
        END LOOP REC_EXPENSE_ACCOUNT;
        
        

        --FI_SLIP_LINE TABLE INSERT ; 차변계정

        FOR LINE_INSERT IN (
            SELECT
                  B.EXPENSE_TYPE    --경비구분[10:판관, 20:제조]
                --, A.COST_CENTER_ID  --원가아이디
                , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
                , SUM(A.SOURCE_AMOUNT) AS GL_AMOUNT   --(최종)감가상각비; 전표에 등록될 금액
                --, COUNT(*) AS CNT
            FROM FI_ASSET_DPR_HISTORY_CG A
                , FI_ASSET_MASTER_CG B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.DPR_TYPE = '20'   --[20 : IFRS]
                AND A.PERIOD_NAME = W_PERIOD_NAME
                AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
                AND A.SLIP_YN = 'Y'
                AND NVL(A.DPR_YN, 'N') != 'Y'
    
                AND A.ASSET_ID = B.ASSET_ID
            GROUP BY B.EXPENSE_TYPE, A.COST_CENTER_ID
            ORDER BY B.EXPENSE_TYPE, A.COST_CENTER_ID
        ) LOOP
        
            SELECT 
                  DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_ACCOUNT_CONTROL_ID_10, '20', t_ACCOUNT_CONTROL_ID_20)    --계정통제ID
                , DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_ACCOUNT_CODE_10, '20', t_ACCOUNT_CODE_20)                --계정코드
                , DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_SLIP_REMARKS_10, '20', t_SLIP_REMARKS_20)                --전표적요
            INTO t_ACCOUNT_CONTROL_ID, t_ACCOUNT_CODE, t_SLIP_REMARKS_LINE            
            FROM DUAL   ;


            --LINE INSERT ; 차변계정
            FI_SLIP_G.INSERT_SLIP_LINE(
                  t_SLIP_LINE_ID    --전표라인 ID
                , V_SLIP_HEADER_ID  --전표헤더 ID
                , W_SOB_ID          --회사아이디
                , W_ORG_ID          --사업부아이디
                
                , t_ACCOUNT_CONTROL_ID  --계정통제ID
                , t_ACCOUNT_CODE        --계정코드
                , '1'                   --차대구분(1-차변, 2-대변)
                , LINE_INSERT.GL_AMOUNT --전표금액
                
                , t_CURRENCY_CODE   --통화
                , NULL              --환율
                , NULL              --외화금액
                
                , LINE_INSERT.CC_CODE   --잔액관리항목1; 실은 관리항목1이다.; 원가코드
                
                , NULL  --잔액관리항목2
                , NULL  --관리항목1; 실은 관리항목3이다.
                , NULL  --관리항목2
                , NULL  --관리항목3
                , NULL  --관리항목4
                , NULL  --관리항목5
                , NULL  --관리항목6
                , NULL  --관리항목7
                , NULL  --관리항목8
                , NULL  --관리항목9
                , NULL  --관리항목10
                , NULL  --관리항목11
                , NULL  --관리항목12
                
                , t_SLIP_REMARKS_LINE   --전표적요
                
                , NULL              --UNLIQUIDATE_SLIP_HEADER_ID(미정산발생전표HEADER ID)
                , NULL              --UNLIQUIDATE_SLIP_LINE_ID(미정산자료정산전표LINE ID)
                , P_USER_ID         --CREATED_BY(생성자)
                , t_CREATED_TYPE    --생성구분(M:메뉴얼, I:INTERFACE)
                , t_SOURCE_TABLE    --INTERFACE 소스테이블                                
                , NULL              --SOURCE_HEADER_ID(INTERFACE 소스 HEADER ID)
                , NULL              --SOURCE_LINE_ID(INTERFACE 소스 LINE ID)
            );
            
        END LOOP LINE_INSERT; 
        
        
        
        --FI_SLIP_LINE TABLE INSERT ; 대변계정
        
        --FI_SLIP_LINE(전표상세) 테이블에 INSERT할 시 대변 계정관련 필요정보 추출
        SELECT
              ACCOUNT_CONTROL_ID    --계정통제ID    
            , ACCOUNT_CODE          --계정코드
            , SLIP_REMARKS          --전표적요
        INTO t_ACCOUNT_CONTROL_ID, t_ACCOUNT_CODE, t_SLIP_REMARKS_LINE    
        FROM FI_AUTO_JOURNAL_DET
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE_CD = 'DPR'
            AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD
            AND ACCOUNT_DR_CR = '2' --1:차변, 2:대변         
        ;
        
        --대변에 설정될 금액 추출
        
        SELECT SUM(A.SOURCE_AMOUNT) AS GL_AMOUNT   --(최종)감가상각비; 전표에 등록될 금액
        INTO t_GL_AMOUNT
        FROM FI_ASSET_DPR_HISTORY_CG A
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID
            AND A.DPR_TYPE = '20'   --[20 : IFRS]
            AND A.PERIOD_NAME = W_PERIOD_NAME
            AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
            AND A.SLIP_YN = 'Y'
            AND NVL(A.DPR_YN, 'N') != 'Y'
        ;
        
        
        --LINE INSERT ; 대변계정
        FI_SLIP_G.INSERT_SLIP_LINE(
              t_SLIP_LINE_ID    --전표라인 ID
            , V_SLIP_HEADER_ID  --전표헤더 ID
            , W_SOB_ID          --회사아이디
            , W_ORG_ID          --사업부아이디
            
            , t_ACCOUNT_CONTROL_ID  --계정통제ID
            , t_ACCOUNT_CODE        --계정코드
            , '2'                   --차대구분(1-차변, 2-대변)
            , t_GL_AMOUNT           --전표금액
            
            , t_CURRENCY_CODE   --통화
            , NULL              --환율
            , NULL              --외화금액            
            , NULL  --잔액관리항목1; 실은 관리항목1이다.            
            , NULL  --잔액관리항목2
            , NULL  --관리항목1; 실은 관리항목3이다.
            , NULL  --관리항목2
            , NULL  --관리항목3
            , NULL  --관리항목4
            , NULL  --관리항목5
            , NULL  --관리항목6
            , NULL  --관리항목7
            , NULL  --관리항목8
            , NULL  --관리항목9
            , NULL  --관리항목10
            , NULL  --관리항목11
            , NULL  --관리항목12
            
            , t_SLIP_REMARKS_LINE   --전표적요
            
            , NULL              --UNLIQUIDATE_SLIP_HEADER_ID(미정산발생전표HEADER ID)
            , NULL              --UNLIQUIDATE_SLIP_LINE_ID(미정산자료정산전표LINE ID)
            , P_USER_ID         --CREATED_BY(생성자)
            , t_CREATED_TYPE    --생성구분(M:메뉴얼, I:INTERFACE)
            , t_SOURCE_TABLE    --INTERFACE 소스테이블                                
            , NULL              --SOURCE_HEADER_ID(INTERFACE 소스 HEADER ID)
            , NULL              --SOURCE_LINE_ID(INTERFACE 소스 LINE ID)
        );        
              


        --FI_ASSET_MASTER_CG(자산대장) 테이블의 IFRS_DPR_STATUS_CODE[(IFRS)상각상태]를 UPDATE한다.
        --마지막회차의 자료 
        --  [1.인 경우 : 상각완료]
        --  [2.가 아닌 경우 : 상각진행]
        --자산상태가 매각 또는 폐기인 자료 
        --  [1.매각 또는 폐기가 발생된 월인 경우 : 상각완료]
        --  [1.매각 또는 폐기가 발생된 이전월인(월이 아닌) 경우 : 상각진행]

        --IFRS_DPR_STATUS_CODE : (IFRS)상각상태
        FOR UPD_IFRS_DPR_STATUS_CODE IN (
            SELECT 
                  A.ASSET_ID    --자산아이디
                , B.ASSET_CODE  --자산코드                
                , A.DISUSE_YN   --마지막회차여부
                , C.CHANGE_CODE --변경사유코드
            FROM FI_ASSET_DPR_HISTORY_CG A
                , FI_ASSET_MASTER_CG B
                , (
                    SELECT
                          ASSET_ID    --자산아이디
                        --, CHARGE_ID --변경사유아이디
                        , FI_COMMON_G.GET_CODE_F(CHARGE_ID, SOB_ID, ORG_ID) AS CHANGE_CODE  --변경사유코드
                        --, CHARGE_DATE   --변경일자
                        --, TO_CHAR(CHARGE_DATE, 'YYYY-MM') AS CHANGE_YM --변경년월
                    FROM FI_ASSET_HISTORY_CG
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND TO_CHAR(CHARGE_DATE, 'YYYY-MM') = W_PERIOD_NAME
                        AND FI_COMMON_G.GET_CODE_F(CHARGE_ID, SOB_ID, ORG_ID) IN ('90', '91')   --90:폐기, 91:매각
                ) C                
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND A.PERIOD_NAME = W_PERIOD_NAME
                AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
                AND A.SLIP_YN = 'Y'
                AND NVL(A.DPR_YN, 'N') != 'Y'
                
                AND A.ASSET_ID = B.ASSET_ID
                AND A.ASSET_ID = C.ASSET_ID(+)
        ) LOOP
        
            IF UPD_IFRS_DPR_STATUS_CODE.DISUSE_YN = 'Y' THEN --마지막회차이면
            
                UPDATE FI_ASSET_MASTER_CG
                SET   IFRS_DPR_STATUS_CODE = '90'   --90:상각완료
                    , LAST_UPDATE_DATE = V_SYSDATE  --최종수정일자
                    , LAST_UPDATED_BY = P_USER_ID   --최종수정자                
                WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;
            
            ELSE    --마지막회차가 아니면
            
                IF UPD_IFRS_DPR_STATUS_CODE.CHANGE_CODE IN ('90', '91') THEN    --매각 또는 폐기가 발생된 월이면; 90:폐기, 91:매각

                    UPDATE FI_ASSET_MASTER_CG
                    SET   IFRS_DPR_STATUS_CODE = '90'   --90:상각완료
                        , LAST_UPDATE_DATE = V_SYSDATE  --최종수정일자
                        , LAST_UPDATED_BY = P_USER_ID   --최종수정자                
                    WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;

                ELSE

                    UPDATE FI_ASSET_MASTER_CG
                    SET   IFRS_DPR_STATUS_CODE = '10'   --10:상각진행
                        , LAST_UPDATE_DATE = V_SYSDATE  --최종수정일자
                        , LAST_UPDATED_BY = P_USER_ID   --최종수정자                
                    WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;

                END IF;

            END IF;
            
        END LOOP UPD_IFRS_DPR_STATUS_CODE;         




        --마지막 단계이다.
        --전표생성작업 완료 후 전표로 생성된 자료에 대해 상각여부 칼럼 등을 UPDATE한다.
        --이 작업을 해 줘야 매번 원하는 자료에 대해서 만 전표를 생성할 수 있기 때문이다.
        UPDATE FI_ASSET_DPR_HISTORY_CG
        SET   DPR_YN            = 'Y'               --상각여부
            , SLIP_DATE         = t_SLIP_DATE       --전표일자
            , SLIP_HEADER_ID    = V_SLIP_HEADER_ID  --전표헤더ID
            , GL_NUM            = t_SLIP_NUM        --전표번호
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND DPR_TYPE = '20'   --회계구분[20 : IFRS]
            AND PERIOD_NAME = W_PERIOD_NAME
            AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
            AND SLIP_YN = 'Y'
            AND NVL(DPR_YN, 'N') != 'Y'   ;      
        
      
        

        EXCEPTION WHEN OTHERS THEN
            --FCM_10182 : 전표생성 중 오류가 발생했습니다.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL);
    END;
    
    --FCM_10112 : 전표생성 작업이 정상완료되었습니다.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10334', NULL);
    
END CREATE_DPR_SLIP;







--전표삭제 : 선택한 전표를 삭제한다.
PROCEDURE DELETE_DPR_SLIP( 
      W_SOB_ID          IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID          IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디
    , W_PERIOD_NAME     IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월    
    , P_SLIP_HEADER_ID  IN  FI_ASSET_DPR_HISTORY_CG.SLIP_HEADER_ID%TYPE    --전표헤더ID
    , P_GL_NUM          IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE            --전표번호
    , P_USER_ID         IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --최종수정자
    
    , O_MESSAGE         OUT VARCHAR2    --전표삭제 후 화면으로 작업 결과 반환함.
)

AS

V_SYSDATE   DATE := GET_LOCAL_DATE(W_SOB_ID);   --수정일자

BEGIN

/*
--아래의 승인여부에 따라 삭제여부를 묻는 문장은 취지상 맞는 문장이다.
--그러나 주석으로 처리한다.
--이유는 재무팀에서 생성하는 본 전표에 대해 승인을 해제할 수 있는 기능의 프로그램이 없어서이다.
--참조>현업에서 등록한 전표에 대해서는 전표승인관리 프로그램에서 승인여부를 제어할 수 있다.

    --삭제하려는 전표의 승인여부를 파악하여 승인된 전표라면 삭제할 수 없다고 메시지를 보여준다.
    IF TRIM(FI_SLIP_G.SLIP_CONFIRM_YN_F(P_SLIP_HEADER_ID)) = 'Y' THEN
    
        --FCM_10408 : 이미 승인된 전표입니다. 승인해제 후 삭제바랍니다.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10408', NULL);

        --아래 RETURN문은 PARAMETER를 넘기는 경우에 참조하려고 지우지 않은것이다.
        --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Delete');

        RETURN;
    END IF;
*/

    --회계전표 삭제.
    FI_SLIP_G.DELETE_SLIP_LIST(P_SLIP_HEADER_ID);  --전표삭제
    
        
    --FI_ASSET_MASTER_CG(자산대장)테이블의 IFRS_DPR_STATUS_CODE[(IFRS)상각상태]칼럼의 값을 전표생성 이전의 값으로 변경한다.
    
    UPDATE FI_ASSET_MASTER_CG
    SET   IFRS_DPR_STATUS_CODE = '10'   --(IFRS)상각상태[10:상각진행]
        , LAST_UPDATE_DATE = V_SYSDATE  --최종수정일자
        , LAST_UPDATED_BY = P_USER_ID   --최종수정자    
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID IN (
                SELECT ASSET_ID    --자산아이디
                FROM FI_ASSET_DPR_HISTORY_CG A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND PERIOD_NAME = W_PERIOD_NAME
                    AND GL_NUM = P_GL_NUM
            )   ;   
        


    --자산별로 상각이 된 자료가 없는 경우 상각상태를 [20:미상각]으로 변경한다.

    UPDATE FI_ASSET_MASTER_CG
    SET   IFRS_DPR_STATUS_CODE = '20'   --(IFRS)상각상태[20:미상각]
        , LAST_UPDATE_DATE = V_SYSDATE  --최종수정일자
        , LAST_UPDATED_BY = P_USER_ID   --최종수정자   
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID IN
            (                
                SELECT ASSET_ID    --자산아이디
                FROM
                (
                    SELECT A.ASSET_ID    --자산아이디
                        --, (SELECT ASSET_CODE FROM FI_ASSET_MASTER_CG WHERE ASSET_ID = A.ASSET_ID) AS ASSET_CODE
                        , (
                            SELECT COUNT(*)
                            FROM FI_ASSET_DPR_HISTORY_CG
                            WHERE SOB_ID = W_SOB_ID
                                AND ORG_ID = W_ORG_ID
                                AND ASSET_ID = A.ASSET_ID
                                AND PERIOD_NAME != W_PERIOD_NAME
                                AND NVL(DPR_YN, 'N') = 'Y'    --(감가)상각여부
                        ) AS CNT
                    FROM FI_ASSET_DPR_HISTORY_CG A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID
                        AND A.GL_NUM = P_GL_NUM
                )
                WHERE CNT = 0                
            )   ;




    --전표생성에 따라 변경된 칼럼의 값등을 전표생성 이전 상태로 변경한다.  
    UPDATE FI_ASSET_DPR_HISTORY_CG
    SET   SLIP_YN           = NULL      --전표생성여부       
        , DPR_YN            = NULL      --상각여부
        , SLIP_DATE         = NULL      --전표일자
        , SLIP_HEADER_ID    = NULL      --전표헤더ID
        , GL_NUM            = NULL      --전표번호
        , LAST_UPDATE_DATE  = V_SYSDATE --최종수정일자
        , LAST_UPDATED_BY   = P_USER_ID --최종수정자        
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND PERIOD_NAME = W_PERIOD_NAME
        AND GL_NUM = P_GL_NUM ;
        
                
      
    --FCM_10336 : 전표삭제 작업이 정상 완료되었습니다.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10336', NULL);
    
    EXCEPTION WHEN OTHERS THEN
        --FCM_10182 : 전표삭제 중 오류가 발생했습니다.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10409', NULL);    

END DELETE_DPR_SLIP;






--전표별상각자산 조회
PROCEDURE LIST_SLIP_DPR(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --사업부아이디 
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --상각년월
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --자산유형아이디      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID            --회사아이디
        , ORG_ID            --사업부아이디
        , ASSET_CATEGORY_ID --자산유형아이디
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NAME   --자산유형명칭
        , PERIOD_NAME   --상각년월
        , GL_NUM        --전표번호
        , SLIP_DATE     --전표일자
        , (SELECT REMARK FROM FI_SLIP_HEADER WHERE GL_NUM = A.GL_NUM) AS GL_REMARK --전표적요        
        , SLIP_HEADER_ID    --전표헤더ID
        , '' AS O_MESSAGE   --DELETE_DPR_SLIP PROCEDURE에서 값 넘김 (전표삭제 후 화면으로 작업 결과 반환함)
    FROM FI_ASSET_DPR_HISTORY_CG A
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GL_NUM IS NOT NULL  --전표번호가 있는 자료만
        AND PERIOD_NAME = NVL(W_PERIOD_NAME, PERIOD_NAME)
        AND ASSET_CATEGORY_ID = NVL(W_ASSET_CATEGORY_ID, ASSET_CATEGORY_ID)
    GROUP BY SOB_ID, ORG_ID, ASSET_CATEGORY_ID, PERIOD_NAME, GL_NUM, SLIP_DATE, SLIP_HEADER_ID 
    ORDER BY PERIOD_NAME DESC, GL_NUM DESC;

END LIST_SLIP_DPR;







--전표별분개자료 조회
PROCEDURE LIST_SLIP_JOURNAL(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --사업부아이디
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --전표번호  
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          ASSET_CATEGORY_ID   --자산유형아이디
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --자산유형
        , EXPENSE_TYPE    --경비구분
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', EXPENSE_TYPE, W_SOB_ID) AS EXPENSE_TYPE_NM   --경비구분
        , COST_CENTER_ID  --원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(COST_CENTER_ID) AS CC_DESC  --원가명
        , LAST_DPR_AMOUNT    --(최종)감가상각비
    FROM
        (
            SELECT          
                  A.ASSET_CATEGORY_ID                       --자산유형아이디
                , B.EXPENSE_TYPE                            --경비구분
                , A.COST_CENTER_ID                          --원가아이디
                , SUM(A.SOURCE_AMOUNT) AS LAST_DPR_AMOUNT   --(최종)감가상각비              
            FROM FI_ASSET_DPR_HISTORY_CG A
                , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
                   FROM FI_ASSET_MASTER_CG
                   WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                   ) B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.DPR_TYPE = '20' --회계구분[20 : IFRS]
                AND A.GL_NUM = W_GL_NUM
                
                AND A.ASSET_ID = B.ASSET_ID
            GROUP BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID
        )    
    ORDER BY ASSET_CATEGORY_ID, EXPENSE_TYPE, COST_CENTER_ID   ;

END LIST_SLIP_JOURNAL;







--전표별자산원장 조회
PROCEDURE LIST_SLIP_ASSET(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --사업부아이디
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --전표번호  
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --회사아이디
        , A.ORG_ID              --사업부아이디       
        , A.PERIOD_NAME         --상각년월    
        , A.ASSET_CATEGORY_ID   --자산유형아이디
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --자산유형
        , B.EXPENSE_TYPE    --경비구분
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --경비구분     
        , A.COST_CENTER_ID  --원가아이디
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명      
        , A.ASSET_ID                            --자산아이디
        , B.ASSET_CODE                          --자산코드
        , B.ASSET_DESC                          --자산명       
        , A.DPR_COUNT                           --상각회차    
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(최종)감가상각비   
        , A.SLIP_DATE   --전표일자
        , A.GL_NUM      --전표번호               
        , A.DPR_TYPE    --회계구분_코드[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --회계구분
        , A.DPR_METHOD_TYPE --감가상각방법_코드
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --감가상각방법          
    FROM FI_ASSET_DPR_HISTORY_CG A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER_CG
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --회계구분[20 : IFRS]
        AND A.GL_NUM = W_GL_NUM
        
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID, B.ASSET_CODE    ;

END LIST_SLIP_ASSET;


END FI_ASSET_DPR_HISTORY_CG_G;
/
