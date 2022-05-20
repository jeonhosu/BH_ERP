select pm.name
     , pm.person_num
     , x.*
  from hrd_ot_line x
    , hrm_person_master pm
    , ( select ph.person_id
             , ph.floor_id
          from hrd_person_history ph
        where ph.effective_date_fr  <= to_date('2012-10-22', 'yyyy-mm-dd')
          and (ph.effective_date_to >= to_date('2012-10-22', 'yyyy-mm-dd') or ph.effective_date_to is null)
          and ph.floor_id           in ( select hf.FLOOR_ID
                                           from hrm_floor_v hf
                                         where hf.FLOOR_CODE = '302'
                                       )
      ) sx
where x.person_id           = pm.person_id
  and x.person_id           = sx.person_id
  and x.work_date           = '2012-10-22'
