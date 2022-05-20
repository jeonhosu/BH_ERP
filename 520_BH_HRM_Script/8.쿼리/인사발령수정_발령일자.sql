
select HH.CHARGE_DATE
     , HL.CHARGE_DATE
     , HH.*
     , HL.*
  from hrm_history_header hh
     , hrm_history_line   hl
 where hh.history_header_id   = hl.history_header_id
   --and hh.history_num         = '2011-00144'
   AND EXISTS
         ( SELECT 'X'
             FROM HRM_HISTORY_LINE HL
            WHERE HL.HISTORY_HEADER_ID        = HH.HISTORY_HEADER_ID
              AND HL.CHARGE_DATE              != HH.CHARGE_DATE
         )
;

select *
  from hrm_person_master x
 where x.person_id       = 3527
 ;  
 
update hrm_history_line hl
   set hl.charge_date   = ( select hh.charge_date
                              from hrm_history_header hh
                             where hh.history_header_id = hl.history_header_id
                          )
 where exists
         ( select 'x'
             from hrm_history_header hh
            where hh.history_header_id = hl.history_header_id
              --and hh.history_num       = '2011-00144'
              AND EXISTS
                   ( SELECT 'X'
                       FROM HRM_HISTORY_LINE HHL
                      WHERE HHL.HISTORY_HEADER_ID        = HH.HISTORY_HEADER_ID
                        AND HHL.CHARGE_DATE              != HH.CHARGE_DATE
                   )
         )
;

select *
  FROM HRM_HISTORY_HEADER HH
 WHERE EXISTS
         ( SELECT 'X'
             FROM HRM_HISTORY_LINE HL
            WHERE HL.HISTORY_HEADER_ID        = HH.HISTORY_HEADER_ID
              AND HL.CHARGE_DATE              != HH.CHARGE_DATE
         )
;         
