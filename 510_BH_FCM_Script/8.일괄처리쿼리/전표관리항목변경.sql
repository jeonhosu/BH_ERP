SELECT *
  FROM FI_TEMP_GT TG
FOR UPDATE  
;

SELECT *
  FROM FI_SLIP_LINE SL
WHERE SL.SLIP_LINE_ID = 17024
;

SELECT *
  FROM FI_SLIP_LINE SL
WHERE SL.SOB_ID     = 20
  AND EXISTS
        ( SELECT 'X'
            FROM FI_TEMP_GT FG
          WHERE FG.VARCHAR_1  = SL.SLIP_LINE_ID
        )
;


UPDATE FI_SLIP_LINE SL
  SET ( SL.MANAGEMENT1
      , SL.MANAGEMENT2
      , SL.REFER1
      , SL.REFER2
      ) = 
      ( SELECT FG.VARCHAR_7
             , FG.VARCHAR_8
             , FG.VARCHAR_9
             , FG.VARCHAR_10
          FROM FI_TEMP_GT FG
        WHERE FG.VARCHAR_1  = SL.SLIP_LINE_ID
      )
WHERE SL.SOB_ID     = 20
  AND EXISTS
        ( SELECT 'X'
            FROM FI_TEMP_GT FG
          WHERE FG.VARCHAR_1  = SL.SLIP_LINE_ID
        )
;

SELECT *
  FROM FI_SLIP_MANAGEMENT_ITEM SMI
WHERE SMI.SLIP_LINE_ID         = 14880
;
