create or replace package FI_SLIP_LINE_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_SLIP_LINE_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 16-NOV-2010  Sung Kil Te        Initialize
--==============================================================================

       PROCEDURE FI_SLIP_LINE_LIST_SELECT1( P_CURSOR             OUT TYPES.TCURSOR
                                          , W_SOB_ID             IN  FI_SLIP_LINE.SOB_ID%TYPE
                                          , W_ORG_ID             IN  FI_SLIP_LINE.ORG_ID%TYPE
                                          , W_PERIOD_FROM        IN  FI_SLIP_LINE.PERIOD_NAME%TYPE
                                          , W_PERIOD_TO          IN  FI_SLIP_LINE.PERIOD_NAME%TYPE
                                          , W_ACCOUNT_CODE_FROM  IN  FI_AGGREGATE.ACCOUNT_CODE%TYPE
                                          , W_ACCOUNT_CODE_TO    IN  FI_AGGREGATE.ACCOUNT_CODE%TYPE
                                          );

end FI_SLIP_LINE_LIST_G;

 
/
create or replace package body FI_SLIP_LINE_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_SLIP_LINE_LIST_G
-- Description  : 보조부원장 조회
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 16-NOV-2010  Sung Kil Te        Initialize
--==============================================================================


       PROCEDURE FI_SLIP_LINE_LIST_SELECT1( P_CURSOR             OUT TYPES.TCURSOR
                                          , W_SOB_ID             IN  FI_SLIP_LINE.SOB_ID%TYPE
                                          , W_ORG_ID             IN  FI_SLIP_LINE.ORG_ID%TYPE
                                          , W_PERIOD_FROM        IN  FI_SLIP_LINE.PERIOD_NAME%TYPE
                                          , W_PERIOD_TO          IN  FI_SLIP_LINE.PERIOD_NAME%TYPE
                                          , W_ACCOUNT_CODE_FROM  IN  FI_AGGREGATE.ACCOUNT_CODE%TYPE
                                          , W_ACCOUNT_CODE_TO    IN  FI_AGGREGATE.ACCOUNT_CODE%TYPE
                                          )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT '1'           GUBUN
                      , CC.ACCOUNT_CODE
                      , CC.ACCOUNT_DESC
                      , '-------'    PERIOD_NAME
                      , NULL         GL_DATE
                      , NULL         GL_NUM
                      , NULL         DEPT_ID
                      ,  NULL        DEPT_NAME
                      , NVL(BB.ACCOUNT_DR_CR, CC.ACCOUNT_DR_CR)   ACCOUNT_DR_CR
                      , NVL(BB.DR_AMOUNT,0)   DR_AMOUNT
                      , NVL(BB.CR_AMOUNT,0)   CR_AMOUNT
                      , 0                   REMAIN_AMOUNT
                      , '전 월 이 월'       REMARK
                      , NULL   MANAGEMENT1
                      , NULL   MANAGEMENT2
                      , NULL   REFER1
                      , NULL   REFER2
                      , NULL   REFER3
                      , NULL   REFER4
                      , NULL   REFER5
                      , NULL   REFER6
                      , 0      GL_CURRENCY_AMOUNT
                      , 0      EXCHANGE_RATE
                      , NULL   REFER_DATE1
                      , NULL   REFER_DATE2
                      , NULL   TAX_REG_NO
                      , NULL   CUSTOMER_MANE
                
                FROM
                -- 당월 발생 계정코드
                 (SELECT  SL.ACCOUNT_CONTROL_ID
                    FROM  FI_SLIP_LINE  SL
                      ,  FI_AGGREGATE   FA
                   WHERE  SL.ACCOUNT_CONTROL_ID   = FA.ACCOUNT_CONTROL_ID(+)
                     AND SL.SOB_ID                = FA.SOB_ID(+)
                     AND SL.PERIOD_NAME           BETWEEN W_PERIOD_FROM AND W_PERIOD_TO
                     AND SL.SOB_ID                = W_SOB_ID
                  GROUP BY SL.ACCOUNT_CONTROL_ID 
                  )   AA
                 -- 이월발생 계정 DATA
                 ,(SELECT FA.ACCOUNT_CONTROL_ID
                     , MAX(FAC.ACCOUNT_DR_CR)  ACCOUNT_DR_CR
                     , SUM(DECODE(SUBSTR(W_PERIOD_FROM, 6, 2), '01', 0,
                           DECODE(SUBSTR(PERIOD_NAME,   6, 2), '01', (FA.PERIOD_DR_AMOUNT), FA.PERIOD_DR_AMOUNT)))   DR_AMOUNT
                     , SUM(DECODE(SUBSTR(W_PERIOD_FROM, 6, 2), '01', 0,
                           DECODE(SUBSTR(PERIOD_NAME,   6, 2), '01', (FA.PERIOD_CR_AMOUNT), FA.PERIOD_CR_AMOUNT)))   CR_AMOUNT
                  FROM FI_AGGREGATE              FA
                     , FI_ACCOUNT_CONTROL        FAC
                 WHERE FA.PERIOD_NAME       BETWEEN SUBSTR(W_PERIOD_FROM, 1, 5) || '01'
                                                     AND SUBSTR(W_PERIOD_FROM, 1, 5)
                                                      || DECODE(SUBSTR(W_PERIOD_FROM, 6, 2), '01','01', TRIM(TO_CHAR(TO_NUMBER(SUBSTR(W_PERIOD_FROM, 6, 2)) - 1, '00')))
                   AND FA.ACCOUNT_CODE      BETWEEN NVL(W_ACCOUNT_CODE_FROM, FA.ACCOUNT_CODE)
                                                     AND NVL(W_ACCOUNT_CODE_TO, FA.ACCOUNT_CODE)
                   AND FA.SOB_ID               = W_SOB_ID
                   AND FAC.ACCOUNT_CONTROL_ID  = FA.ACCOUNT_CONTROL_ID
                   AND FAC.SOB_ID              = FA.SOB_ID
                 GROUP BY FA.ACCOUNT_CONTROL_ID )  BB
                , FI_ACCOUNT_CONTROL   CC
                 
                WHERE  BB.ACCOUNT_CONTROL_ID(+)  = AA.ACCOUNT_CONTROL_ID
                  AND  CC.ACCOUNT_CONTROL_ID     = AA.ACCOUNT_CONTROL_ID              
                  AND  CC.ACCOUNT_CODE    BETWEEN  NVL(W_ACCOUNT_CODE_FROM, CC.ACCOUNT_CODE)
                                             AND    NVL(W_ACCOUNT_CODE_TO, CC.ACCOUNT_CODE)
                  
                UNION ALL

                SELECT '2'       GUBUN
                     , FSL.ACCOUNT_CODE
                     , FAC.ACCOUNT_DESC
                     , FSL.PERIOD_NAME
                     , FSL.GL_DATE
                     , FSL.GL_NUM
                     , FSH.DEPT_ID
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(FSH.DEPT_ID)  DEPT_NAME
                     , FSL.ACCOUNT_DR_CR
                     , DECODE(FSL.ACCOUNT_DR_CR, '1', FSL.GL_AMOUNT, 0)   DR_AMOUNT
                     , DECODE(FSL.ACCOUNT_DR_CR, '2', FSL.GL_AMOUNT, 0)   CR_AMOUNT
                     , SUM(DECODE(FSL.ACCOUNT_DR_CR, '1', FSL.GL_AMOUNT, FSL.GL_AMOUNT * -1))
                           OVER (PARTITION BY FSL.ACCOUNT_CODE ORDER BY FSL.ACCOUNT_CODE, FSL.SLIP_LINE_ID, FSL.SLIP_LINE_SEQ)  REMAIN_AMOUNT
                     , FSL.REMARK
                     , FSL.MANAGEMENT1
                     , FSL.MANAGEMENT2
                     , FSL.REFER1
                     , FSL.REFER2
                     , FSL.REFER3
                     , FSL.REFER4
                     , FSL.REFER5
                     , FSL.REFER6
                     , FSL.GL_CURRENCY_AMOUNT
                     , FSL.EXCHANGE_RATE
                     , FSL.REFER_DATE1
                     , FSL.REFER_DATE2
                     , SCV.TAX_REG_NO            TAX_REG_NO
                     , SCV.SUPP_CUST_NAME        CUSTOMER_MANE
                  FROM FI_SLIP_LINE              FSL
                      ,FI_SLIP_HEADER            FSH
                   -- ,(SELECT  UNIQUE ACCOUNT_CODE
                   --     FROM  FI_AGGREGATE
                   --    WHERE  PERIOD_NAME   =   W_PERIOD_FROM
                   --      AND  ACCOUNT_CODE  BETWEEN W_ACCOUNT_CODE_FROM AND W_ACCOUNT_CODE_TO)  FA
                      ,FI_SUPP_CUST_V            SCV
                      ,FI_ACCOUNT_CONTROL        FAC
                 WHERE FSL.SOB_ID              = W_SOB_ID
                   AND FSL.PERIOD_NAME         BETWEEN W_PERIOD_FROM AND W_PERIOD_TO
                   AND FSL.ACCOUNT_CODE        BETWEEN NVL(W_ACCOUNT_CODE_FROM, FSL.ACCOUNT_CODE)
                                                   AND NVL(W_ACCOUNT_CODE_TO, FSL.ACCOUNT_CODE)
                   AND FSL.CONFIRM_YN          = 'Y'
                   AND FSL.CUSTOMER_ID         = SCV.SUPP_CUST_ID(+)
                   AND FSL.SOB_ID              = SCV.SOB_ID(+)
                   AND FSH.SOB_ID              = FSL.SOB_ID
                   AND FSH.SLIP_HEADER_ID      = FSL.SLIP_HEADER_ID
                -- AND FFSL.ACCOUNT_CODE       = FSL.ACCOUNT_CODE*/
                   AND FAC.ACCOUNT_CONTROL_ID  = FSL.ACCOUNT_CONTROL_ID
              ORDER BY ACCOUNT_CODE                  
                     , GUBUN
                     , GL_DATE
                     , GL_NUM
                     ;


       END;


end FI_SLIP_LINE_LIST_G;
/
