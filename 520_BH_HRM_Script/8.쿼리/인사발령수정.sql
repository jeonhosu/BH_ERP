UPDATE HRM_HISTORY_LINE HL
  SET (HL.POST_ID, HL.PAY_GRADE_ID)
      = 
      (SELECT PM.POST_ID, PM.PAY_GRADE_ID
         FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = HL.PERSON_ID
      )
WHERE EXISTS( SELECT 'X'
                FROM HRM_HISTORY_HEADER HH
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HH.SOB_ID               = 10
                AND HH.ORG_ID               = 101
            )
;            
