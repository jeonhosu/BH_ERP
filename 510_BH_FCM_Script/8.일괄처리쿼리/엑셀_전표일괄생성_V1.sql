/*
--1. 업로드 대상자료 INSERT.(iNSERT 전에 기존 자료 백업 받기--> 혹시 삭제할 경우 생길때 대비).
SELECT *
  FROM FI_SLIP_LINE_TEMP
FOR UPDATE
;
*/
/*

-- 전표 라인 조회.
SELECT * FROM FI_SLIP_LINE SL
WHERE EXISTS ( SELECT 'X'
                 FROM FI_SLIP_HEADER SH
               WHERE SH.SLIP_HEADER_ID   = SL.SLIP_HEADER_ID
                 AND EXISTS ( SELECT 'X'
                                FROM FI_SLIP_LINE_TEMP SLT
                              WHERE SLT.SLIP_HEADER_ID     = SH.SLIP_HEADER_ID
                            )
             )
;
-- 전표 헤더 조회.
SELECT * FROM FI_SLIP_HEADER SH
WHERE EXISTS ( SELECT 'X'
                FROM FI_SLIP_LINE_TEMP SLT
              WHERE SLT.SLIP_HEADER_ID     = SH.SLIP_HEADER_ID
            )
;
*/

-- 전표 INSERT.
DECLARE
  V_SYSDATE             DATE := SYSDATE;
  V_SLIP_NUM            VARCHAR2(20);
  V_SLIP_HEADER_ID      NUMBER;
  V_SLIP_LINE_ID        NUMBER;
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
                   , NVL(SLT.GL_DATE, SLT.SLIP_DATE) AS GL_DATE
                   , SLT.GL_NUM
                   , SUM(DECODE(SLT.ACCOUNT_DR_CR, '1', SLT.GL_AMOUNT, 0)) AS GL_AMOUNT
                   , FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(SLT.SOB_ID) CURRENCY_CODE
                   , MAX(SLT.EXCHANGE_RATE) EXCHANGE_RATE
                   , SUM(DECODE(SLT.ACCOUNT_DR_CR, '1', SLT.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
                   , MAX(SLT.REMARK) AS REMARK
                   , EU.USER_ID
                FROM FI_SLIP_LINE_TEMP SLT
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
                   , NVL(SLT.GL_DATE, SLT.SLIP_DATE)
                   , SLT.GL_NUM
                   , EU.USER_ID
             ORDER BY SLT.SLIP_DATE, SLT.SLIP_NUM
             )
  LOOP
    V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', C1.SOB_ID, C1.SLIP_DATE, C1.USER_ID); 
    
    FI_SLIP_G.INSERT_SLIP_HEADER
                ( P_SLIP_HEADER_ID      => V_SLIP_HEADER_ID
                , P_SLIP_DATE           => C1.SLIP_DATE
                , P_SLIP_NUM            => V_SLIP_NUM
                , P_SOB_ID              => C1.SOB_ID
                , P_ORG_ID              => C1.ORG_ID 
                , P_DEPT_ID             => C1.DEPT_ID
                , P_PERSON_ID           => C1.PERSON_ID
                , P_BUDGET_DEPT_ID      => NULL
                , P_SLIP_TYPE           => C1.SLIP_TYPE
                , P_GL_DATE             => C1.GL_DATE
                , P_GL_NUM              => V_SLIP_NUM 
                , P_REQ_BANK_ACCOUNT_ID => NULL
                , P_REQ_PAYABLE_TYPE    => NULL
                , P_REQ_PAYABLE_DATE    => NULL
                , P_REMARK              => C1.REMARK
                , P_USER_ID             => -100
                , P_CREATED_TYPE        => 'M'
                , P_SOURCE_TABLE        => NULL
                , P_SOURCE_HEADER_ID    => NULL
                );
                
    UPDATE FI_SLIP_LINE_TEMP SLT
      SET SLT.SLIP_NUM                  = V_SLIP_NUM
        , SLT.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
        , SLT.GL_NUM                    = V_SLIP_NUM
    WHERE SLT.SLIP_DATE                 = C1.SLIP_DATE
      AND SLT.SLIP_NUM                  = C1.SLIP_NUM
      AND SLT.SOB_ID                    = C1.SOB_ID
    ;
    
    -- LINE INSERT.
    FOR R1 IN ( SELECT SLT.SLIP_DATE
                     , SLT.SLIP_NUM
                     , SLT.SLIP_LINE_SEQ
                     , SLT.SLIP_HEADER_ID
                     , SLT.SOB_ID
                     , SLT.ORG_ID
                     , SLT.SLIP_TYPE
                     , SLT.GL_DATE
                     , SLT.GL_NUM
                     , AC.ACCOUNT_CONTROL_ID
                     , SLT.ACCOUNT_CODE
                     , SLT.ACCOUNT_DR_CR     
                     , SLT.GL_AMOUNT AS GL_AMOUNT
                     , SLT.CURRENCY_CODE
                     , SLT.EXCHANGE_RATE EXCHANGE_RATE
                     , SLT.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                     , SLT.MANAGEMENT1
                     , SLT.MANAGEMENT2
                     , SLT.REFER1
                     , SLT.REFER2
                     , SLT.REFER3
                     , SLT.REFER4
                     , SLT.REFER5
                     , SLT.REFER6
                     , SLT.REFER7
                     , SLT.REFER8
                     , SLT.REFER9
                     , SLT.REMARK
                  FROM FI_SLIP_LINE_TEMP SLT
                     , FI_ACCOUNT_CONTROL AC
                WHERE SLT.ACCOUNT_CODE              = AC.ACCOUNT_CODE
                  AND SLT.SOB_ID                    = AC.SOB_ID
                  AND SLT.SLIP_DATE                 = C1.SLIP_DATE
                  AND SLT.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
                ORDER BY SLT.SLIP_LINE_SEQ  
               )
    LOOP
      FI_SLIP_G.INSERT_SLIP_LINE
              ( P_SLIP_LINE_ID               => V_SLIP_LINE_ID
              , P_SLIP_HEADER_ID             => V_SLIP_HEADER_ID
              , P_SOB_ID                     => R1.SOB_ID
              , P_ORG_ID                     => R1.ORG_ID
              , P_ACCOUNT_CONTROL_ID         => R1.ACCOUNT_CONTROL_ID
              , P_ACCOUNT_CODE               => R1.ACCOUNT_CODE
              , P_ACCOUNT_DR_CR              => R1.ACCOUNT_DR_CR
              , P_GL_AMOUNT                  => R1.GL_AMOUNT
              , P_CURRENCY_CODE              => R1.CURRENCY_CODE
              , P_EXCHANGE_RATE              => R1.EXCHANGE_RATE
              , P_GL_CURRENCY_AMOUNT         => R1.GL_CURRENCY_AMOUNT
              , P_MANAGEMENT1                => R1.MANAGEMENT1
              , P_MANAGEMENT2                => R1.MANAGEMENT2
              , P_REFER1                     => R1.REFER1
              , P_REFER2                     => R1.REFER2
              , P_REFER3                     => R1.REFER3
              , P_REFER4                     => R1.REFER4
              , P_REFER5                     => R1.REFER5
              , P_REFER6                     => R1.REFER6
              , P_REFER7                     => R1.REFER7
              , P_REFER8                     => R1.REFER8
              , P_REFER9                     => R1.REFER9
              , P_REMARK                     => R1.REMARK
              , P_UNLIQUIDATE_SLIP_HEADER_ID => NULL
              , P_UNLIQUIDATE_SLIP_LINE_ID   => NULL
              , P_USER_ID                    => -100
              , P_LINE_TYPE                  => 'M'
              , P_SOURCE_TABLE               => NULL
              , P_SOURCE_HEADER_ID           => NULL
              , P_SOURCE_LINE_ID             => NULL
              );
    END LOOP R1;
  END LOOP C1;
  
END;

/*
-- 전표 라인 삭제.
DELETE FROM FI_SLIP_LINE SL
WHERE EXISTS ( SELECT 'X'
                 FROM FI_SLIP_HEADER SH
               WHERE SH.SLIP_HEADER_ID   = SL.SLIP_HEADER_ID
                 AND EXISTS ( SELECT 'X'
                                FROM FI_SLIP_LINE_TEMP SLT
                              WHERE SLT.SLIP_HEADER_ID     = SH.SLIP_HEADER_ID
                            )
             )
;
-- 전표 헤더 삭제.
DELETE FROM FI_SLIP_HEADER SH
WHERE EXISTS ( SELECT 'X'
                FROM FI_SLIP_LINE_TEMP SLT
              WHERE SLT.SLIP_HEADER_ID     = SH.SLIP_HEADER_ID
            )
;
*/
