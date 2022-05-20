/*
--1. 임시데이터 삭제.
DELETE FROM FI_SLIP_LINE_INTERFACE_TEMP;

--2. 업로드 대상자료 INSERT.(iNSERT 전에 기존 자료 백업 받기--> 혹시 삭제할 경우 생길때 대비).
SELECT *
  FROM FI_SLIP_LINE_INTERFACE_TEMP
--WHERE ACCOUNT_CODE = '2100500'  
FOR UPDATE
;

-- 3번 실행후 4,5번을 조회해서 생성된 데이터 백업.

--4.(3번) 실행후 생성된 전표 헤더 조회.
SELECT * FROM FI_SLIP_HEADER_INTERFACE SHI
WHERE EXISTS ( SELECT 'X'
                FROM FI_SLIP_LINE_INTERFACE_TEMP SLIT
              WHERE SLIT.HEADER_INTERFACE_ID     = SHI.HEADER_INTERFACE_ID
            )
;

--5. (3번) 실행후 생성된 전표 라인 조회.
SELECT * FROM FI_SLIP_LINE_INTERFACE SLI
WHERE EXISTS ( SELECT 'X'
                 FROM FI_SLIP_HEADER_INTERFACE SHI
               WHERE SHI.HEADER_INTERFACE_ID   = SLI.HEADER_INTERFACE_ID
                 AND EXISTS ( SELECT 'X'
                                FROM FI_SLIP_LINE_INTERFACE_TEMP SLIT
                              WHERE SLIT.HEADER_INTERFACE_ID     = SHI.HEADER_INTERFACE_ID
                            )
             )
;

*/

-- 3. 경비전표 INSERT(생성).
DECLARE
  V_SYSDATE             DATE := SYSDATE;
  V_SLIP_NUM            VARCHAR2(20);
  V_HEADER_INTERFACE_ID NUMBER;
  V_LINE_INTERFACE_ID   NUMBER;
  
BEGIN

  FOR C1 IN ( -- 헤더 생성.
              SELECT SLT.SLIP_DATE
                   , SLT.SLIP_NUM     
                   , SLT.SOB_ID
                   , SLT.ORG_ID
                   , DM.M_DEPT_ID AS DEPT_ID
                   , PM.PERSON_ID
                   , NULL AS BUDGET_DEPT_ID
                   , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SLT.SOB_ID) AS ACCOUNT_BOOK_ID
                   , SLT.SLIP_TYPE
                   , SLT.JOURNAL_HEADER_ID
                   , SUM(DECODE(SLT.ACCOUNT_DR_CR, '1', SLT.GL_AMOUNT, 0)) AS GL_AMOUNT
                   , SLT.CURRENCY_CODE
                   , MAX(SLT.EXCHANGE_RATE) EXCHANGE_RATE
                   , SUM(DECODE(SLT.ACCOUNT_DR_CR, '1', SLT.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
                   , MAX(SLT.REMARK) AS REMARK
                   , EU.USER_ID
                FROM FI_SLIP_LINE_INTERFACE_TEMP SLT
                  , HRM_PERSON_MASTER PM
                  , ( SELECT HDM.HR_DEPT_ID
                           , HDM.M_DEPT_ID
                        FROM HRM_DEPT_MAPPING HDM
                      WHERE HDM.MODULE_TYPE     = 'FCM'
                    ) DM
                  , EAPP_USER EU
              WHERE SLT.PERSON_NUM                = PM.PERSON_NUM
                AND PM.DEPT_ID                    = DM.HR_DEPT_ID
                AND SLT.SOB_ID                    = PM.SOB_ID
                AND PM.PERSON_ID                  = EU.PERSON_ID
                AND SLT.SOB_ID                    = &W_SOB_ID
              GROUP BY SLT.SLIP_DATE
                   , SLT.SLIP_NUM     
                   , SLT.SOB_ID
                   , SLT.ORG_ID
                   , DM.M_DEPT_ID
                   , PM.PERSON_ID
                   , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SLT.SOB_ID)
                   , SLT.SLIP_TYPE
                   , SLT.JOURNAL_HEADER_ID
                   , SLT.SLIP_DATE
                   , SLT.SLIP_NUM
                   , SLT.CURRENCY_CODE
                   , EU.USER_ID
             ORDER BY SLT.SLIP_DATE, SLT.SLIP_NUM
             )
  LOOP
    V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', C1.SOB_ID, C1.SLIP_DATE, C1.USER_ID); 
    
    FI_SLIP_INTERFACE_G.INSERT_HEADER_IF
                ( P_HEADER_INTERFACE_ID => V_HEADER_INTERFACE_ID
                , P_SLIP_DATE           => C1.SLIP_DATE
                , P_SLIP_NUM            => V_SLIP_NUM
                , P_SOB_ID              => C1.SOB_ID
                , P_ORG_ID              => C1.ORG_ID 
                , P_DEPT_ID             => C1.DEPT_ID
                , P_PERSON_ID           => C1.PERSON_ID
                , P_BUDGET_DEPT_ID      => NULL
                , P_SLIP_TYPE           => C1.SLIP_TYPE
                , P_JOURNAL_HEADER_ID   => C1.JOURNAL_HEADER_ID
                , P_REQ_BANK_ACCOUNT_ID => NULL
                , P_REQ_PAYABLE_TYPE    => NULL
                , P_REQ_PAYABLE_DATE    => NULL
                , P_REMARK              => C1.REMARK
                , P_SUBSTANCE           => NULL
                , P_USER_ID             => -100                
                );
    
    UPDATE FI_SLIP_LINE_INTERFACE_TEMP SLT
      SET SLT.SLIP_NUM                  = V_SLIP_NUM
        , SLT.HEADER_INTERFACE_ID       = V_HEADER_INTERFACE_ID
    WHERE SLT.SLIP_DATE                 = C1.SLIP_DATE
      AND SLT.SLIP_NUM                  = C1.SLIP_NUM
      AND SLT.SOB_ID                    = C1.SOB_ID
    ;
    
    -- LINE INSERT.
    FOR R1 IN ( SELECT SLT.SLIP_DATE
                     , SLT.SLIP_NUM
                     , SLT.SLIP_LINE_SEQ
                     , SLT.HEADER_INTERFACE_ID
                     , SLT.SOB_ID
                     , SLT.ORG_ID
                     , AC.ACCOUNT_CONTROL_ID
                     , SLT.ACCOUNT_CODE
                     , SLT.ACCOUNT_DR_CR     
                     , SLT.GL_AMOUNT AS GL_AMOUNT
                     , SLT.CURRENCY_CODE
                     , SLT.EXCHANGE_RATE EXCHANGE_RATE
                     , SLT.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                     , REPLACE(SLT.MANAGEMENT1, ',', '') MANAGEMENT1
                     , REPLACE(SLT.MANAGEMENT2, ',', '') MANAGEMENT2
                     , REPLACE(SLT.REFER1, ',', '') REFER1
                     , REPLACE(SLT.REFER2, ',', '') REFER2
                     , REPLACE(SLT.REFER3, ',', '') REFER3
                     , REPLACE(SLT.REFER4, ',', '') REFER4
                     , REPLACE(SLT.REFER5, ',', '') REFER5
                     , REPLACE(SLT.REFER6, ',', '') REFER6
                     , REPLACE(SLT.REFER7, ',', '') REFER7
                     , REPLACE(SLT.REFER8, ',', '') REFER8
                     , REPLACE(SLT.REFER9, ',', '') REFER9
                     , REPLACE(SLT.REFER10, ',', '') REFER10
                     , REPLACE(SLT.REFER11, ',', '') REFER11
                     , REPLACE(SLT.REFER12, ',', '') REFER12
                     , SLT.REMARK
                  FROM FI_SLIP_LINE_INTERFACE_TEMP SLT
                     , FI_ACCOUNT_CONTROL AC
                WHERE SLT.ACCOUNT_CODE              = AC.ACCOUNT_CODE
                  AND SLT.SOB_ID                    = AC.SOB_ID
                  AND SLT.SLIP_DATE                 = C1.SLIP_DATE
                  AND SLT.HEADER_INTERFACE_ID       = V_HEADER_INTERFACE_ID
                ORDER BY SLT.SLIP_LINE_SEQ  
               )
    LOOP
      FI_SLIP_INTERFACE_G.INSERT_LINE_IF
            ( P_LINE_INTERFACE_ID   => V_LINE_INTERFACE_ID
            , P_HEADER_INTERFACE_ID => V_HEADER_INTERFACE_ID
            , P_SOB_ID              => R1.SOB_ID
            , P_ORG_ID              => R1.ORG_ID
            , P_BUDGET_DEPT_ID      => C1.BUDGET_DEPT_ID
            , P_CUSTOMER_ID         => NULL
            , P_ACCOUNT_CONTROL_ID  => R1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE        => R1.ACCOUNT_CODE
            , P_COST_CENTER_ID      => NULL
            , P_ACCOUNT_DR_CR       => R1.ACCOUNT_DR_CR
            , P_GL_AMOUNT           => R1.GL_AMOUNT
            , P_CURRENCY_CODE       => R1.CURRENCY_CODE
            , P_EXCHANGE_RATE       => R1.EXCHANGE_RATE
            , P_GL_CURRENCY_AMOUNT  => R1.GL_CURRENCY_AMOUNT
            , P_BANK_ACCOUNT_ID     => NULL
            , P_MANAGEMENT1         => R1.MANAGEMENT1
            , P_MANAGEMENT2         => R1.MANAGEMENT2
            , P_REFER1              => R1.REFER1
            , P_REFER2              => R1.REFER2
            , P_REFER3              => R1.REFER3
            , P_REFER4              => R1.REFER4
            , P_REFER5              => R1.REFER5
            , P_REFER6              => R1.REFER6
            , P_REFER7              => R1.REFER7
            , P_REFER8              => R1.REFER8
            , P_REFER9              => R1.REFER9            
            , P_REFER10             => R1.REFER10
            , P_REFER11             => R1.REFER11
            , P_REFER12             => R1.REFER12            
            , P_VOUCH_CODE          => NULL
            , P_REFER_RATE          => NULL
            , P_REFER_AMOUNT        => NULL
            , P_REFER_DATE1         => NULL
            , P_REFER_DATE2         => NULL
            , P_REMARK              => R1.REMARK
            , P_FUND_CODE           => NULL
            , P_USER_ID             => -100
            );
                
    END LOOP R1;
  END LOOP C1;
  
END;

/*
-- 잘못 생성됬을 경우 임시테이블에 생성된 전표번호를 가지고 전표 삭제함.
-- 전표 라인 삭제.
DELETE FROM FI_SLIP_LINE_INTERFACE SLI
WHERE EXISTS ( SELECT 'X'
                 FROM FI_SLIP_HEADER_INTERFACE SHI
               WHERE SHI.HEADER_INTERFACE_ID   = SLI.HEADER_INTERFACE_ID
                 AND EXISTS ( SELECT 'X'
                                FROM FI_SLIP_LINE_INTERFACE_TEMP SLIT
                              WHERE SLIT.HEADER_INTERFACE_ID     = SHI.HEADER_INTERFACE_ID
                            )
             )
;
-- 전표 헤더 삭제.
DELETE FROM FI_SLIP_HEADER_INTERFACE SHI
WHERE EXISTS ( SELECT 'X'
                FROM FI_SLIP_LINE_INTERFACE_TEMP SLIT
              WHERE SLIT.HEADER_INTERFACE_ID     = SHI.HEADER_INTERFACE_ID
            )
;
*/
