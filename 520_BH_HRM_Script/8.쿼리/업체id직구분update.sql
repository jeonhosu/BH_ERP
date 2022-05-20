select * from hrd_day_leave t
where t.corp_id             = 65
  and t.sob_id              = 10
  and t.org_id              = 101
--  and t.created_by          = 50
  and t.work_date           = &w_work_date
;

update hrd_day_leave t
  set (t.corp_id, t.job_category_id)
      =
      (select 65, x.job_category_id
        from hrm_person_master x
       where x.corp_id         = 65
         and x.sob_id          = t.sob_id
         and x.org_id          = t.org_id
         and x.person_id       = t.person_id      
      )    
where t.corp_id             = 1
  and t.sob_id              = 10
  and t.org_id              = 101
  and t.created_by          = 50
  and t.creation_date       = to_date('2010-12-14 14:44:12', 'yyyy-mm-dd hh24:mi:ss') 
  and t.work_date           between &w_start_date and &w_end_date
;


select *
/*  set (t.corp_id, t.job_category_id)
      =*/
     /*, (select x.job_category_id
        from hrm_person_master x
       where x.corp_id         = 65
         and x.sob_id          = t.sob_id
         and x.org_id          = t.org_id
         and x.person_id       = t.person_id
      )*/  
from hrd_day_leave t        
where t.corp_id             = 1
  and t.sob_id              = 10
  and t.org_id              = 101
  and t.created_by          = 50
  and t.creation_date       = to_date('2010-12-14 14:44:12', 'yyyy-mm-dd hh24:mi:ss')    
