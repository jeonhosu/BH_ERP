--2.기초자료를 생성한다.
DECLARE
  t_REMAIN_AMT  NUMBER := 0;
  t_LOOKUP_TYPE VARCHAR2(50);
BEGIN
    -- 2-0. 기존자료 삭제.
    DELETE FROM FI_MANAGEMENT_LEDGER_DETAIL;
    
    -- LOOKUP TYPE.
    BEGIN
      SELECT MC.LOOKUP_TYPE
        INTO t_LOOKUP_TYPE
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID      = &W_MANAGEMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      t_LOOKUP_TYPE := NULL;
    END;
    
    FOR C1 IN ( SELECT AC.ACCOUNT_CONTROL_ID
                     , AC.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AC.ACCOUNT_DR_CR
                     , AC.SOB_ID
                  FROM FI_ACCOUNT_CONTROL AC
                WHERE AC.ACCOUNT_CODE     BETWEEN &W_ACCOUNT_CODE_FR AND &W_ACCOUNT_CODE_TO
                  AND AC.SOB_ID           = 10
                  AND AC.ENABLED_FLAG     = 'Y'
              )
    LOOP
        --2-1.이월금액 기초자료 생성
        INSERT INTO FI_MANAGEMENT_LEDGER_DETAIL(
              RET_SEQ           --조회일련번호
            , GL_DATE           --회계일자
            , REMARKS           --적요
            , DR_AMT            --차변(금액)
            , CR_AMT            --대변(금액)
            , REMAIN_AMT        --잔액
            , ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , MANAGEMENT_CD     --관리항목코드
            , MANAGEMENT_NM     --관리항목명
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
            , NULL              --계정코드
            , NULL              --계정명
            , NULL              --관리항목코드
            , NULL              --관리항목명
            , NULL              --전표헤더아이디
            , NULL              --전표번호 
            , NULL              --전표라인ID
        FROM
            (
                SELECT ML.ACCOUNT_DR_CR, SUM(ML.GL_AMOUNT) AS GL_AMOUNT
                FROM FI_MANAGEMENT_LEDGER_V ML
                WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                    AND ML.MANAGEMENT_ID    = &W_MANAGEMENT_ID
                    AND ((&W_MANAGEMENT_CD  IS NULL AND 1 = 1)
                    OR   (&W_MANAGEMENT_CD  IS NOT NULL AND ML.MANAGEMENT_VAL = &W_MANAGEMENT_CD))
                    AND ML.GL_DATE BETWEEN TO_DATE(TO_CHAR(&W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                   AND --이월금액 조회 종료일자는 
                                      CASE 
                                          --조회기간의 시작일이 1월1일이면 해당년의 1월 1일
                                          WHEN TO_CHAR(&W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(&W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                          ELSE &W_DEAL_DATE_FR - 1    --아니면 시작일의 전일
                                      END
                    AND ML.SLIP_TYPE = --전표유형은
                                      CASE 
                                          WHEN TO_CHAR(&W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --조회기간의 시작일이 1월1일이면 '기초잔액'만
                                          ELSE SLIP_TYPE   --모든 전표유형
                                      END
                GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
            )   ;

        --2-2.조회기간 내 발생된 자료에 대한 기초자료 생성
        INSERT INTO FI_MANAGEMENT_LEDGER_DETAIL(
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
        )
        SELECT
              ROWNUM + 1 AS ROW_NUM    --조회일련번호
              
            --원 회계일자에 1초씩을 더해준다.
            --이유 : 동일 회계일자에 대해 GROUP BY ROOLUP이 적용되면 순서가 달라지는 문제를 해결하기 위험이다.
            , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --회계일자 
            
            , REMARKS           --적요
            , DR_AMT            --차변
            , CR_AMT            --대변                                
            , 0 REMAIN_AMT      --잔액
            , ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , MANAGEMENT_VAL    --관리항목코드
            , NULL              --거래처명
            , SLIP_HEADER_ID    --전표헤더아이디            
            , GL_NUM            --전표번호
            , SLIP_LINE_ID      --전표라인ID                
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
              AND ML.MANAGEMENT_ID      = &W_MANAGEMENT_ID
              AND ((&W_MANAGEMENT_CD    IS NULL AND 1 = 1)
              OR   (&W_MANAGEMENT_CD    IS NOT NULL AND ML.MANAGEMENT_VAL = &W_MANAGEMENT_CD))
              AND ML.GL_DATE            BETWEEN &W_DEAL_DATE_FR AND &W_DEAL_DATE_TO
              AND ML.SLIP_TYPE          != 'BLS'  --전표유형은 '기초잔액'이 아닌것
            ORDER BY ML.GL_DATE    
        )   ;                   

        --3.잔액을 수정한다.
        t_REMAIN_AMT := 0;
        FOR AMT_MODIFY IN (
            SELECT MLD.RET_SEQ, C1.ACCOUNT_DR_CR, MLD.DR_AMT, MLD.CR_AMT, MLD.REMAIN_AMT
              FROM FI_MANAGEMENT_LEDGER_DETAIL MLD
            ORDER BY RET_SEQ
        ) LOOP 
            
            UPDATE FI_MANAGEMENT_LEDGER_DETAIL ML
            SET ML.REMAIN_AMT = DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE ML.RET_SEQ = AMT_MODIFY.RET_SEQ    ;
            
            
            SELECT DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 

        --대상 자료에 거래처자료가 있다면 거래처코드를 수정한다.
        UPDATE FI_MANAGEMENT_LEDGER_DETAIL T
        SET T.MANAGEMENT_NM = FI_ACCOUNT_CONTROL_G.ITEM_DESC_F(t_LOOKUP_TYPE, T.MANAGEMENT_CD, 10)
        WHERE GL_NUM IS NOT NULL    ;
    END LOOP C1;
    
END;
/*
    --5. 세부자료 조회
    
    --OPEN P_CURSOR FOR

    SELECT
          '' BASE_MM        --회계년월
        , GL_DATE           --회계일자
        , REMARKS           --적요
        , MANAGEMENT_CD     --관리항목코드
        , MANAGEMENT_NM     --관리항목명            
        , DR_AMT            --차변(금액)
        , CR_AMT            --대변(금액)
        , REMAIN_AMT        --잔액
        , ACCOUNT_CODE      --계정코드
        , ACCOUNT_DESC      --계정명
        , SLIP_HEADER_ID    --전표헤더아이디
        , GL_NUM            --전표번호
        , SLIP_LINE_ID      --전표라인아이디
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE RET_SEQ = 1

    UNION ALL
    
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ 기 간 합 계 ]', DECODE(GROUPING(GL_DATE), 1, '[ 월    계 ]',  REMARKS)) AS REMARKS
        , MANAGEMENT_CD
        , MANAGEMENT_NM            
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
        , REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE RET_SEQ > 1
    GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), 
          (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, MANAGEMENT_CD, MANAGEMENT_NM, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID))
    ;
    */
