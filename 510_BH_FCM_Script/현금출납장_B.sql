SELECT '1'            AS GUBUN
     , &W_GL_DATE_FR       AS GL_DATE
     , NULL           AS GL_NUM
     , NULL           AS SLIP_LINE_ID
     , '이월금액'     AS REMARK
     , SUM(DECODE(&W_GL_DATE_FR , TRUNC(&W_GL_DATE_FR, 'MONTH'), REMAIN_AMOUNT, REMAIN_AMOUNT + INS_AMOUNT - OUT_AMOUNT)) INS_AMOUNT
     , 0              AS OUT_AMOUNT 
  FROM 
      ( SELECT SUM(DECODE(SLI.ACCOUNT_DR_CR,'1', SLI.GL_AMOUNT,0)) AS INS_AMOUNT
              ,SUM(DECODE(SLI.ACCOUNT_DR_CR,'2', SLI.GL_AMOUNT,0)) AS OUT_AMOUNT
              ,0       REMAIN_AMOUNT
          FROM FI_SLIP_LINE  SLI
         WHERE SLI.GL_DATE BETWEEN  TRUNC(&W_GL_DATE_FR, 'MONTH') AND 
                               CASE WHEN &W_GL_DATE_FR -1 < TRUNC(&W_GL_DATE_FR, 'MONTH')
                               THEN TRUNC(&W_GL_DATE_FR, 'MONTH')
                               ELSE &W_GL_DATE_FR -1  END
           AND SLI.SOB_ID       =&W_SOB_ID
           AND SLI.ACCOUNT_CONTROL_ID IN ( SELECT  ACCOUNT_CONTROL_ID
                                             FROM  FI_ACCOUNT_CONTROL
                                            WHERE  ACCOUNT_CLASS_ID  = 723
                                              AND  SOB_ID            = &W_SOB_ID)

        UNION ALL
        
        SELECT 0   AS INS_AMOUNT
              ,0   AS OUT_AMOUNT
              ,SUM(FDS.DR_SUM)   AS REMAIN_AMOUNT
          FROM FI_DAILY_SUM   FDS
         WHERE FDS.GL_DATE      = TRUNC(&W_GL_DATE_FR, 'MONTH')
           AND FDS.GL_DATE_SEQ  =  0
           AND FDS.SOB_ID       = &W_SOB_ID
           AND FDS.ACCOUNT_CONTROL_ID IN ( SELECT  ACCOUNT_CONTROL_ID
                                             FROM  FI_ACCOUNT_CONTROL
                                            WHERE  ACCOUNT_CLASS_ID  = 723
                                              AND  SOB_ID            = &W_SOB_ID)
       )
             
UNION ALL

SELECT  '2'                   AS GUBUN
       ,SLI.GL_DATE           AS GL_DATE
       ,SLI.GL_NUM            AS GL_NUM
       ,SLI.SLIP_LINE_ID      AS SLIP_LINE_ID
       ,SLI.REMARK            AS REMARK
       ,DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0)  AS INS_AMOUNT
       ,DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0)  AS OUT_AMOUNT 
  FROM  FI_SLIP_LINE  SLI
 WHERE SLI.GL_DATE     = &W_GL_DATE_FR
   AND SLI.SOB_ID      =&W_SOB_ID
   AND SLI.ACCOUNT_CONTROL_ID IN ( SELECT  ACCOUNT_CONTROL_ID
                                     FROM  FI_ACCOUNT_CONTROL
                                    WHERE  ACCOUNT_CLASS_ID  = 723
                                      AND  SOB_ID            = &W_SOB_ID )
