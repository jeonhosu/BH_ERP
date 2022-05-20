CREATE OR REPLACE PACKAGE HRW_WITHHOLDING_FILE_G
AS

-- 원천징수이행상황신고서 전산매체 작성 메인.
  PROCEDURE MAIN_WITHHOLDING
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            );

-- 전산매체 작성.
  PROCEDURE SET_FILE1
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-------------------------------------------------------------------------------
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            );

-------------------------------------------------------------------------------
-- 파일 암호화 비밀번호 조회
-------------------------------------------------------------------------------
  PROCEDURE GET_ENCRYPT_PWD
            ( P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ENCRYPT_PWD       OUT VARCHAR2
            );
                        
END HRW_WITHHOLDING_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_WITHHOLDING_FILE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_WITHHOLDING_FILE_G
/* DESCRIPTION  : 원천징수이행상황신고서 전산매체 생성.
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 원천징수이행상황신고서 전산매체 작성 메인.
  PROCEDURE MAIN_WITHHOLDING
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_STATUS                  VARCHAR2(2) := 'F';
    V_MESSAGE                 VARCHAR2(300);
  BEGIN
/*    -- 마감 여부 체크.
    IF HRW_WITHHOLDING_SET_G.CLOSED_WITHHOLDING_YN(P_WITHHOLDING_DOC_ID) <> 'Y' THEN
      -- 마감처리 되지 않은 자료는 FILE 생성 못함.
      RAISE_APPLICATION_ERROR(-20001, '해당 원천징수이행상황신고서는 마감되지 않았습니다. 마감 후 다시 실행하세요');
      RETURN;
    END IF;*/
    
    -- 기존자료 삭제;
    DELETE FROM HRM_REPORT_FILE_GT;
    
    -- 자료 생성;
    SET_FILE1
      ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
      , P_SOB_ID                => P_SOB_ID
      , P_ORG_ID                => P_ORG_ID
      , O_STATUS                => V_STATUS
      , O_MESSAGE               => V_MESSAGE
      );
      
    OPEN P_CURSOR1 FOR
      SELECT RF.REPORT_FILE
        FROM HRM_REPORT_FILE_GT RF
      WHERE RF.SOB_ID             = P_SOB_ID
        AND RF.ORG_ID             = P_ORG_ID
        AND RF.SEQ_NUM            IS NOT NULL
      ORDER BY RF.SEQ_NUM, RF.SORT_NUM
      ;
      
  END MAIN_WITHHOLDING;

-- 전산매체 작성.
  PROCEDURE SET_FILE1
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(400); 
    
    V_VAT_NUMBER                VARCHAR2(20);     -- 사업자번호.                     
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT REPLACE(OU.VAT_NUMBER, '-', '') AS VAT_NUMBER
        INTO V_VAT_NUMBER
        FROM HRM_OPERATING_UNIT OU
      WHERE OU.SOB_ID             = P_SOB_ID
        AND OU.ORG_ID             = P_ORG_ID
        AND EXISTS
              ( SELECT 'X'
                  FROM HRW_WITHHOLDING_DOC WD
                WHERE WD.CORP_ID            = OU.CORP_ID
                  AND WD.WITHHOLDING_DOC_ID = P_WITHHOLDING_DOC_ID
              )
        AND (OU.DEFAULT_FLAG      = 'Y'
          OR (OU.DEFAULT_FLAG     = 'N'
          AND ROWNUM              <= 1))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '사업자번호 조회 오류입니다. 확인하세요';
      RETURN;
    END;
    FOR C1 IN ( SELECT  --> HEADER <--
                        '21'                             -- 자료구분;
                     || 'O201'                          -- 서식코드;
                     || RPAD(V_VAT_NUMBER, 13, ' ')     -- 납세자ID;
                     || '14'                            -- 세목구분;
                     || CASE
                          WHEN WD.WITHHOLDING_TYPE = '1' THEN '1'
                          WHEN WD.WITHHOLDING_TYPE = '2' THEN '2'
                          WHEN WD.WITHHOLDING_TYPE = '3' THEN '5'
                        END                             -- 신고구분;
                     || '8'                             -- 납세자구분;
                     || RPAD(TO_CHAR(WD.SUBMIT_DATE, 'YYYYMM'), 6, ' ')   -- 제출연월;
                     || RPAD(REPLACE(WD.PAY_YYYYMM, '-', ''), 6, ' ')     -- 지급연월;
                     || RPAD(REPLACE(WD.STD_YYYYMM, '-', ''), 6, ' ')     -- 귀속연월;
                     || RPAD(HI.HOMETAX_ID, 20, ' ')                      -- 사용자ID;
                     || RPAD(' ', 30 ,' ')                                -- 세무대리인성명;
                     || RPAD(' ', 6, ' ')                                 -- 세무대리인관리번호;
                     || RPAD(' ', 14, ' ')                                -- 세무대리인전화번호;
                     || RPAD(CM.CORP_NAME, 30, ' ')                       -- 법인명(상호);
                     || RPAD(CM.ADDR1 || ' ' || CM.ADDR2, 70, ' ')        -- 사업장소재지;
                     || RPAD(CM.TEL_NUMBER, 14, ' ')                      -- 사업장전화번호;
                     || RPAD(CM.PRESIDENT_NAME, 30, ' ')                  -- 성명(대표자명);
                     || CASE
                          WHEN WD.MONTHLY_YN = 'Y' THEN '1'
                          WHEN WD.HALF_YEARLY_YN = 'Y' THEN '2'
                        END                                               -- 원천신고구분.
                     || RPAD(' ', 10, ' ')                                -- 세무대리인사업자번호;
                     || RPAD(' ', 4, ' ')                                 -- 귀속년도(부표첨부시만 작성);
                     || RPAD(' ', 1, ' ')                                 -- 신고서부표여부;
                     || CASE
                          WHEN NVL(WD.A04_PERSON_CNT, 0) > 0 THEN 'Y'
                          WHEN NVL(WD.A26_PERSON_CNT, 0) > 0 THEN 'Y'
                          WHEN NVL(WD.A46_PERSON_CNT, 0) > 0 THEN 'Y'
                          ELSE 'N'
                        END                                               -- 연말정산여부;
                     || TO_CHAR(SYSDATE, 'YYYYMMDD')                      -- 작성일자;
                     || '9000'                                            -- 세무프로그램코드;
                     || RPAD(NVL(CM.EMAIL, ' '), 50, ' ')                 -- 이메일;
                     || RPAD(WD.INCOME_DISPOSED_YN, 1, 'N')               -- 소득처분여부;
                     || 'N'                                               -- 환급신청여부;
                     || RPAD(' ', 3, ' ')                                 -- 예입처;
                     || RPAD(' ', 20, ' ')                                -- 계좌번호;
                     || 'N'                                               -- 차월이월환급세액승계명세여부;
                     || 'N'                                               -- 기납부세액명세서제출여부;
                     || RPAD(' ', 19, ' ')                                -- 공란;
                        AS H_RECORD_FILE
                        
                     --> 원천징수이행상황신고서 <--
                     ,  '27'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || LPAD(NVL(WD.RECEIVE_REFUND_TAX_AMT, 0), 15, '0')  -- 전월미환급세액.
                     || LPAD(NVL(WD.ALREADY_REFUND_TAX_AMT, 0), 15, '0')  -- 기환급세신청세액.
                     || LPAD(NVL(WD.REFUND_BALANCE_AMT, 0), 15, '0')      -- 차감후잔액(원천).
                     || LPAD(NVL(WD.GENERAL_REFUND_AMT, 0), 15, '0')      -- 일반환급세액.
                     || LPAD(NVL(WD.FINANCIAL_AMT, 0), 15, '0')           -- 신탁재산세액.
                     || LPAD(NVL(WD.ADJUST_REFUND_TAX_AMT, 0), 15, '0')   -- 조정대상환급세액.
                     || LPAD(NVL(WD.THIS_ADJUST_REFUND_TAX_AMT ,0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.NEXT_REFUND_TAX_AMT, 0), 15, '0')     -- 차월이월환급세액.
                     || 'N'                                               -- 일괄납부여부.
                     || LPAD(NVL(WD.ETC_REFUND_FINANCIAL_AMT, 0), 15, '0')   -- 그밖의 환급세액 금융회사등.
                     || LPAD(NVL(WD.REQUEST_REFUND_TAX_AMT, 0), 15, '0')  -- 환급신청액.
                     || 'N'                                               -- 사업자단위과세여부.
                     || LPAD(NVL(WD.ETC_REFUND_MERGER_AMT, 0), 15, '0')   -- 그밖의 환급세액 합병등.
                     || RPAD(' ', 7, ' ')                                 -- 공란.
                        AS B_RECORD_FILE
                        
                     --> 원천징수이행솽황신고서-세부<--
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A01'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A01_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A01_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A01_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(NVL(WD.A01_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A01_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A01_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A02'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A02_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A02_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A02_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A02_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A02_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).                          
                     || CASE
                          WHEN NVL(WD.A02_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A02_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A02_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(농특세).
                     || LPAD(NVL(WD.A02_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A02_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A03'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A03_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A03_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A03_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A03_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A03_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A04'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A04_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A04_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A04_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A04_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A04_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || CASE
                          WHEN NVL(WD.A04_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A04_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A04_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(농특세).
                     || LPAD(NVL(WD.A04_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A04_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A10'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A10_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A10_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).                      
                     || CASE
                          WHEN NVL(WD.A10_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(농특세).
                     || CASE
                          WHEN NVL(WD.A10_ADD_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_ADD_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_ADD_TAX_AMT, 0), 15, '0')
                        END                                               -- 가산세.
                     || CASE
                          WHEN NVL(WD.A10_THIS_REFUND_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0), 15, '0')
                        END                                               -- 당월조정환급세액.
                     || CASE
                          WHEN NVL(WD.A10_PAY_INCOME_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 납부세액(소득세등).
                     || CASE
                          WHEN NVL(WD.A10_PAY_SP_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_PAY_SP_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_PAY_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A10_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A20'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A20_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A20_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A20_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A20_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A20_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A20_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A20_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A20_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A21'                                             -- 원천세목코드(퇴직소득연금계좌).
                     || LPAD(NVL(WD.A21_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A21_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A21_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A21_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A21_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A21_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A21_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A21_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A21_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A22'                                             -- 원천세목코드(퇴직소득연금계좌 이외).
                     || LPAD(NVL(WD.A22_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A22_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A22_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A22_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A22_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A22_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A22_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A22_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A22_RECORD_FILE  
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A25'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A25_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A25_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A25_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A25_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A25_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A26'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A26_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A26_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A26_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A26_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A26_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || CASE
                          WHEN NVL(WD.A26_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A26_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A26_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(농특세).
                     || LPAD(NVL(WD.A26_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A26_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A30'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A30_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A30_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A30_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(NVL(WD.A30_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A30_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A30_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A30_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(NVL(WD.A30_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A30_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A41'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A41_PERSON_CNT, 0), 15, '0')          -- 인원(기타소득 연금계좌).
                     || LPAD(NVL(WD.A41_PAYMENT_AMT, 0), 15, '0')         -- 총지급액(기타소득 연금계좌).
                     || LPAD(NVL(WD.A41_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등)(기타소득 연금계좌).
                     || LPAD(0, 15, '0')          -- 징수세액(농특세)(기타소득 연금계좌).
                     || LPAD(NVL(WD.A41_ADD_TAX_AMT, 0), 15, '0')         -- 가산세(기타소득 연금계좌).
                     || LPAD(NVL(WD.A41_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액(기타소득 연금계좌).
                     || LPAD(NVL(WD.A41_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등)(기타소득 연금계좌).
                     || LPAD(0, 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A41_RECORD_FILE  
                       
                     ,  '28'                                              -- 자료구분(기타소득 그외).
                     || 'O201'                                            -- 서식코드(기타소득 그외).
                     || 'A42'                                             -- 원천세목코드(기타소득 그외).
                     || LPAD(NVL(WD.A42_PERSON_CNT, 0), 15, '0')          -- 인원(기타소득 그외).
                     || LPAD(NVL(WD.A42_PAYMENT_AMT, 0), 15, '0')         -- 총지급액(기타소득 그외).
                     || LPAD(NVL(WD.A42_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등)(기타소득 그외).
                     || LPAD(0, 15, '0')          -- 징수세액(농특세)(기타소득 그외).
                     || LPAD(NVL(WD.A42_ADD_TAX_AMT, 0), 15, '0')         -- 가산세(기타소득 그외).
                     || LPAD(NVL(WD.A42_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액(기타소득 그외).
                     || LPAD(NVL(WD.A42_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등)(기타소득 그외).
                     || LPAD(0, 15, '0')      -- 납부세액(농특세)(기타소득 그외).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A42_RECORD_FILE  
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A40'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A40_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A40_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A40_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A40_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A40_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A40_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A40_RECORD_FILE  
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A48'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A48_PERSON_CNT, 0), 15, '0')          -- 인원(연금소득 연금계좌).
                     || LPAD(NVL(WD.A48_PAYMENT_AMT, 0), 15, '0')         -- 총지급액(연금소득 연금계좌).
                     || LPAD(NVL(WD.A48_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등)(연금소득 연금계좌).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세)(연금소득 연금계좌).
                     || LPAD(NVL(WD.A48_ADD_TAX_AMT, 0), 15, '0')         -- 가산세(연금소득 연금계좌).
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액(연금소득 연금계좌).
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등)(연금소득 연금계좌).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세(연금소득 연금계좌)).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A48_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A45'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A45_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A45_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A45_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A45_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A45_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A46'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A46_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A46_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A46_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A46_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A46_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A46_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                     || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A46_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A47'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A47_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A47_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A47_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A47_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A47_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A47_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A47_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A50'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A50_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A50_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A50_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(NVL(WD.A50_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A50_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A50_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A50_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(NVL(WD.A50_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A50_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A60'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A60_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A60_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A60_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(NVL(WD.A60_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A60_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A60_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A60_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(NVL(WD.A60_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A60_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A69'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A69_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(0, 15, '0')                                  -- 총지급액.
                     || LPAD(NVL(WD.A69_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A69_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A69_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A69_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A69_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A70'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A70_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A70_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A70_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A70_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A70_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A70_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A70_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A80'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A80_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A80_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A80_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                     || LPAD(NVL(WD.A80_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A80_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A80_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A80_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A90'                                             -- 원천세목코드.
                     || LPAD(0, 15, '0')                                  -- 인원.
                     || LPAD(0, 15, '0')                                  -- 총지급액.
                     || CASE
                          WHEN NVL(WD.A90_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A90_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A90_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(소득세등).
                     || CASE
                          WHEN NVL(WD.A90_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A90_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A90_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- 징수세액(농특세).
                     || LPAD(NVL(WD.A90_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || LPAD(NVL(WD.A90_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                     || LPAD(NVL(WD.A90_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(NVL(WD.A90_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A90_RECORD_FILE
                       
                     ,  '28'                                              -- 자료구분.
                     || 'O201'                                            -- 서식코드.
                     || 'A99'                                             -- 원천세목코드.
                     || LPAD(NVL(WD.A99_PERSON_CNT, 0), 15, '0')          -- 인원.
                     || LPAD(NVL(WD.A99_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                     || LPAD(NVL(WD.A99_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                     || LPAD(NVL(WD.A99_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                     || LPAD(NVL(WD.A99_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                     || CASE
                          WHEN WD.WITHHOLDING_TYPE = '2' AND NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0), 15, '0') 
                        END                                               -- 당월조정환급세액.
                     || LPAD(NVL(WD.A99_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                     || LPAD(NVL(WD.A99_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                     || RPAD(' ', 21, ' ')                                -- 공란.
                       AS A99_RECORD_FILE
                       
                     ,  CASE
                          WHEN WD.WITHHOLDING_TYPE = '1' THEN '1'         -- 정기;
                          WHEN WD.WITHHOLDING_TYPE = '2' THEN '2'         -- 수정;
                          WHEN WD.WITHHOLDING_TYPE = '3' THEN '5'         -- 기납부;
                        END AS WITHHOLDING_TYPE                           -- 신고구분;
                     , WD.SOURCE_WITHHOLDING_NO                           -- 수정전문서번호;
                  FROM HRW_WITHHOLDING_DOC WD
                    , HRM_CORP_MASTER CM
                    , HRW_HOMETAX_INFO HI
                WHERE WD.CORP_ID            = CM.CORP_ID
                  AND WD.CORP_ID            = HI.CORP_ID
                  AND WD.WITHHOLDING_DOC_ID = P_WITHHOLDING_DOC_ID
              )
    LOOP
      V_SEQ_NUM := 10;
      V_SOURCE_FILE := 'HEADER';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.H_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      -- 원천징수이행상황신고서.
      V_SEQ_NUM := 100;
      V_SOURCE_FILE := 'B_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.B_RECORD_FILE
        , P_SORT_NUM          => 1
        );      
      -- 원천징수이행상황신고서-세부(A01).
      V_SEQ_NUM := 101;
      V_SOURCE_FILE := 'A01_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A01_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 102;
      V_SOURCE_FILE := 'A02_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A02_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 103;
      V_SOURCE_FILE := 'A03_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A03_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 104;
      V_SOURCE_FILE := 'A04_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A04_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 110;
      V_SOURCE_FILE := 'A10_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A10_RECORD_FILE
        , P_SORT_NUM          => 1
        );      
      V_SEQ_NUM := 121;
      V_SOURCE_FILE := 'A21_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A21_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 122;
      V_SOURCE_FILE := 'A22_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A22_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 124;
      V_SOURCE_FILE := 'A20_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A20_RECORD_FILE
        , P_SORT_NUM          => 1
        );                
      V_SEQ_NUM := 125;
      V_SOURCE_FILE := 'A25_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A25_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 126;
      V_SOURCE_FILE := 'A26_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A26_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 130;
      V_SOURCE_FILE := 'A30_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A30_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 141;
      V_SOURCE_FILE := 'A41_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A41_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 142;
      V_SOURCE_FILE := 'A42_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A42_RECORD_FILE
        , P_SORT_NUM          => 1
        );    
      V_SEQ_NUM := 144;
      V_SOURCE_FILE := 'A40_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A40_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 145;
      V_SOURCE_FILE := 'A48_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A48_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 145.5;
      V_SOURCE_FILE := 'A45_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A45_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 146;
      V_SOURCE_FILE := 'A46_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A46_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 147;
      V_SOURCE_FILE := 'A47_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A47_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 150;
      V_SOURCE_FILE := 'A50_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A50_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 160;
      V_SOURCE_FILE := 'A60_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A60_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 169;
      V_SOURCE_FILE := 'A69_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A69_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 170;
      V_SOURCE_FILE := 'A70_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A70_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 180;
      V_SOURCE_FILE := 'A80_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A80_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 190;
      V_SOURCE_FILE := 'A90_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A90_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 199;
      V_SOURCE_FILE := 'A99_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A99_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      -- <수정시녹시 당초분 원천징수이행상황신고서 자료> --
      FOR C2 IN ( SELECT  --> 원천징수이행상황신고서 <--
                          '37'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || LPAD(NVL(WD.RECEIVE_REFUND_TAX_AMT, 0), 15, '0')  -- 전월미환급세액.
                       || LPAD(NVL(WD.ALREADY_REFUND_TAX_AMT, 0), 15, '0')  -- 기환급세신청세액.
                       || LPAD(NVL(WD.REFUND_BALANCE_AMT, 0), 15, '0')      -- 차감후잔액(원천).
                       || LPAD(NVL(WD.GENERAL_REFUND_AMT, 0), 15, '0')      -- 일반환급세액.
                       || LPAD(NVL(WD.FINANCIAL_AMT, 0), 15, '0')           -- 신탁재산세액.
                       || LPAD(NVL(WD.ADJUST_REFUND_TAX_AMT, 0), 15, '0')   -- 조정대상환급세액.
                       || LPAD(NVL(WD.THIS_ADJUST_REFUND_TAX_AMT ,0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.NEXT_REFUND_TAX_AMT, 0), 15, '0')     -- 차월이월환급세액.
                       || 'N'                                               -- 일괄납부여부.
                       || LPAD(NVL(WD.ETC_REFUND_FINANCIAL_AMT, 0), 15, '0')   -- 그밖의 환급세액 금융회사등.
                       || LPAD(NVL(WD.REQUEST_REFUND_TAX_AMT, 0), 15, '0')  -- 환급신청액.
                       || 'N'                                               -- 사업자단위과세여부.
                       || LPAD(NVL(WD.ETC_REFUND_MERGER_AMT, 0), 15, '0')   -- 그밖의 환급세액 합병등.
                       || RPAD(' ', 7, ' ')                                 -- 공란.
                          AS B_RECORD_FILE
                       --> 원천징수이행솽황신고서-세부<--
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A01'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A01_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A01_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A01_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A01_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A01_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A01_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A02'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A02_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A02_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A02_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A02_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A02_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).                          
                       || CASE
                            WHEN NVL(WD.A02_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A02_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A02_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(농특세).
                       || LPAD(NVL(WD.A02_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A02_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A03'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A03_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A03_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A03_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A03_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A03_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A04'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A04_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A04_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A04_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A04_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A04_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || CASE
                            WHEN NVL(WD.A04_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A04_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A04_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(농특세).
                       || LPAD(NVL(WD.A04_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A04_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A10'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A10_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A10_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A10_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A10_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A10_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A10_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A10_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A20'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A20_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A20_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A20_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A20_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A20_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A20_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A20_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A20_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A21'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A21_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A21_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A21_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A21_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A21_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A21_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A21_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A21_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A21_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A22'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A22_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A22_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A22_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A22_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A22_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A22_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A22_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A22_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A22_RECORD_FILE  
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A25'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A25_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A25_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A25_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A25_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A25_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A26'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A26_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A26_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A26_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A26_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A26_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || CASE
                            WHEN NVL(WD.A26_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A26_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A26_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(농특세).
                       || LPAD(NVL(WD.A26_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A26_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A30'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A30_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A30_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A30_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A30_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A30_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A30_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A30_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A30_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A30_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A40'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A40_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A40_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A40_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A40_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A40_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A40_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A40_RECORD_FILE  
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A41'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A41_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A41_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A41_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A41_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A41_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A41_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A41_RECORD_FILE  
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A42'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A42_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A42_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A42_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A42_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A42_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A42_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A42_RECORD_FILE    
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A45'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A45_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A45_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A45_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A45_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A45_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A46'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A46_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A46_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A46_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A46_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A46_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A46_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A46_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A47'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A47_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A47_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A47_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A47_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A47_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A47_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A47_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A48'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A48_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A48_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A48_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A48_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(0, 15, '0')                                  -- 당월조정환급세액.
                       || LPAD(0, 15, '0')                                  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A48_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A50'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A50_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A50_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A50_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A50_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A50_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A50_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A50_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A50_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A50_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A60'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A60_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A60_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A60_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A60_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A60_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A60_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A60_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A60_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A60_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A69'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A69_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(0, 15, '0')                                  -- 총지급액.
                       || LPAD(NVL(WD.A69_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A69_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A69_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A69_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A69_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A70'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A70_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A70_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A70_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A70_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A70_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A70_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A70_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A80'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A80_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A80_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A80_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 징수세액(농특세).
                       || LPAD(NVL(WD.A80_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A80_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A80_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(0, 15, '0')                                  -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A80_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A90'                                             -- 원천세목코드.
                       || LPAD(0, 15, '0')                                  -- 인원.
                       || LPAD(0, 15, '0')                                  -- 총지급액.
                       || CASE
                            WHEN NVL(WD.A90_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A90_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A90_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(소득세등).
                       || CASE
                            WHEN NVL(WD.A90_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A90_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A90_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- 징수세액(농특세).
                       || LPAD(NVL(WD.A90_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || LPAD(NVL(WD.A90_THIS_REFUND_TAX_AMT, 0), 15, '0') -- 당월조정환급세액.
                       || LPAD(NVL(WD.A90_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A90_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A90_RECORD_FILE
                       ,  '28'                                              -- 자료구분.
                       || 'O201'                                            -- 서식코드.
                       || 'A99'                                             -- 원천세목코드.
                       || LPAD(NVL(WD.A99_PERSON_CNT, 0), 15, '0')          -- 인원.
                       || LPAD(NVL(WD.A99_PAYMENT_AMT, 0), 15, '0')         -- 총지급액.
                       || LPAD(NVL(WD.A99_INCOME_TAX_AMT, 0), 15, '0')      -- 징수세액(소득세등).
                       || LPAD(NVL(WD.A99_SP_TAX_AMT, 0), 15, '0')          -- 징수세액(농특세).
                       || LPAD(NVL(WD.A99_ADD_TAX_AMT, 0), 15, '0')         -- 가산세.
                       || CASE
                            WHEN WD.WITHHOLDING_TYPE = '2' AND NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0), 15, '0') 
                          END                                               -- 당월조정환급세액.
                       || LPAD(NVL(WD.A99_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- 납부세액(소득세등).
                       || LPAD(NVL(WD.A99_PAY_SP_TAX_AMT, 0), 15, '0')      -- 납부세액(농특세).
                       || RPAD(' ', 21, ' ')                                -- 공란.
                         AS A99_RECORD_FILE
                    FROM HRW_WITHHOLDING_DOC WD
                      , HRM_CORP_MASTER CM
                      , HRW_HOMETAX_INFO HI
                  WHERE WD.CORP_ID            = CM.CORP_ID
                    AND WD.CORP_ID            = HI.CORP_ID
                    AND WD.WITHHOLDING_NO     = C1.SOURCE_WITHHOLDING_NO
                    AND WD.SOB_ID             = P_SOB_ID
                    AND WD.ORG_ID             = P_ORG_ID
                    AND '2'                   = C1.WITHHOLDING_TYPE
                )
      LOOP
        -- 원천징수이행상황신고서.
        V_SEQ_NUM := 20;
        V_SOURCE_FILE := 'HEADER';
        INSERT_REPORT_FILE
          ( P_SEQ_NUM           => V_SEQ_NUM
          , P_SOURCE_FILE       => V_SOURCE_FILE
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_REPORT_FILE       => C1.H_RECORD_FILE
          , P_SORT_NUM          => 2
          );
        -- 원천징수이행상황신고서-세부(A01).
      V_SEQ_NUM := 201;
      V_SOURCE_FILE := 'A01_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A01_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 202;
      V_SOURCE_FILE := 'A02_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A02_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 203;
      V_SOURCE_FILE := 'A03_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A03_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 204;
      V_SOURCE_FILE := 'A04_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A04_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 210;
      V_SOURCE_FILE := 'A10_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A10_RECORD_FILE
        , P_SORT_NUM          => 1  
        );   
      V_SEQ_NUM := 221;
      V_SOURCE_FILE := 'A21_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A21_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 222;
      V_SOURCE_FILE := 'A22_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A22_RECORD_FILE
        , P_SORT_NUM          => 1
        );                   
      V_SEQ_NUM := 224;
      V_SOURCE_FILE := 'A20_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A20_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 225;
      V_SOURCE_FILE := 'A25_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A25_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 226;
      V_SOURCE_FILE := 'A26_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A26_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 230;
      V_SOURCE_FILE := 'A30_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A30_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 241;
      V_SOURCE_FILE := 'A41_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A41_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 242;
      V_SOURCE_FILE := 'A42_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A42_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 244;
      V_SOURCE_FILE := 'A40_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A40_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 245;
      V_SOURCE_FILE := 'A48_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A48_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 245.5;
      V_SOURCE_FILE := 'A45_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A45_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 246;
      V_SOURCE_FILE := 'A46_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A46_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 247;
      V_SOURCE_FILE := 'A47_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A47_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 250;
      V_SOURCE_FILE := 'A50_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A50_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 260;
      V_SOURCE_FILE := 'A60_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A60_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 269;
      V_SOURCE_FILE := 'A69_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A69_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 270;
      V_SOURCE_FILE := 'A70_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A70_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 280;
      V_SOURCE_FILE := 'A80_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A80_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 290;
      V_SOURCE_FILE := 'A90_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A90_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 299;
      V_SOURCE_FILE := 'A99_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A99_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      END LOOP C2;      
    END LOOP C1;
    O_STATUS := 'S';
  END SET_FILE1;

-------------------------------------------------------------------------------
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            )
  AS
  BEGIN
    INSERT INTO HRM_REPORT_FILE_GT
    ( SEQ_NUM
    , SOURCE_FILE
    , SOB_ID
    , ORG_ID
    , REPORT_FILE
    , SORT_NUM
    ) VALUES
    ( P_SEQ_NUM
    , P_SOURCE_FILE
    , P_SOB_ID
    , P_ORG_ID
    , P_REPORT_FILE
    , P_SORT_NUM
    );  
  END INSERT_REPORT_FILE;

-------------------------------------------------------------------------------
-- 파일 암호화 비밀번호 조회
-------------------------------------------------------------------------------
  PROCEDURE GET_ENCRYPT_PWD
            ( P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ENCRYPT_PWD       OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT HI.ENCRYPT_PWD
        INTO O_ENCRYPT_PWD      
        FROM HRW_HOMETAX_INFO HI
      WHERE HI.CORP_ID            = P_CORP_ID
        AND HI.SOB_ID             = P_SOB_ID
        AND HI.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ENCRYPT_PWD := NULL;  
    END;
  END GET_ENCRYPT_PWD;
  
END HRW_WITHHOLDING_FILE_G;
/
