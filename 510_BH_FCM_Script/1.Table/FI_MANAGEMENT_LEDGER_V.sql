CREATE OR REPLACE VIEW FI_MANAGEMENT_LEDGER_V AS
SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                                --계정코드
    , A.ACCOUNT_DR_CR                               --차대구분(0-차, 1-대)
    , A.GL_DATE                                     --회계일자
    , A.REMARK AS REMARKS                           --적요
    , B.REFER1_ID AS MANAGEMENT_ID                  --관리항목_아이디
    , NVL(A.MANAGEMENT1, 'NONE') AS MANAGEMENT_VAL  --관리항목_값    
    , A.GL_AMOUNT                                   --전표금액
    , A.SLIP_HEADER_ID                              --전표헤더ID
    , A.GL_NUM                                      --전표번호
    , A.SLIP_TYPE                                   --전표유형
    , A.SLIP_LINE_ID                                --전표라인ID
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER1_ID IS NOT NULL

UNION ALL

SELECT    
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                                --계정코드
    , A.ACCOUNT_DR_CR                               --차대구분(0-차, 1-대)
    , A.GL_DATE                                     --회계일자
    , A.REMARK AS REMARKS                           --적요
    , B.REFER2_ID AS MANAGEMENT_ID                  --관리항목_아이디
    , NVL(A.MANAGEMENT2, 'NONE') AS MANAGEMENT_VAL  --관리항목_값
    , A.GL_AMOUNT                                   --전표금액
    , A.SLIP_HEADER_ID                              --전표헤더ID
    , A.GL_NUM                                      --전표번호
    , A.SLIP_TYPE                                   --전표유형 
    , A.SLIP_LINE_ID                                --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER2_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER3_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER1, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER3_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER4_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER2, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER4_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER5_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER3, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER5_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER6_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER4, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER6_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER7_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER5, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE 
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER7_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER8_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER6, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER8_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER9_ID AS MANAGEMENT_ID              --관리항목_아이디
    , NVL(A.REFER7, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER9_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER10_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER8, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER10_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER11_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER9, 'NONE') AS MANAGEMENT_VAL   --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER11_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER12_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER10, 'NONE') AS MANAGEMENT_VAL  --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE 
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.     
    AND B.REFER12_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER13_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER11, 'NONE') AS MANAGEMENT_VAL  --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER13_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER14_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER12, 'NONE') AS MANAGEMENT_VAL  --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.    
    AND B.REFER14_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- 계정ID
    , A.ACCOUNT_CODE                            --계정코드
    , A.ACCOUNT_DR_CR                           --차대구분(0-차, 1-대)
    , A.GL_DATE                                 --회계일자
    , A.REMARK AS REMARKS                       --적요
    , B.REFER15_ID AS MANAGEMENT_ID             --관리항목_아이디
    , NVL(A.REFER13, 'NONE') AS MANAGEMENT_VAL  --관리항목_값
    , A.GL_AMOUNT                               --전표금액
    , A.SLIP_HEADER_ID                          --전표헤더ID
    , A.GL_NUM                                  --전표번호
    , A.SLIP_TYPE                               --전표유형
    , A.SLIP_LINE_ID                            --전표라인ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE

    --계정과목의 관리항목 칼럼에는 값이 설정되지 않은 칼럼임에도 전표자료의 해당하는 칼럼에 
    --의미없는 값(예> '')이 있는 경우가 있어 이런 자료를 제외하고자 한 조치이다.
    AND B.REFER15_ID IS NOT NULL;
comment on table FI_MANAGEMENT_LEDGER_V is '관리항목별원장조회';
