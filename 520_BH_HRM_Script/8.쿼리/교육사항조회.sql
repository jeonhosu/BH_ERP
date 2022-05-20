select pm.name
    , pm.DEPT_NAME
    , pm.POST_NAME
    , pm.ORI_JOIN_DATE
    , pm.RETIRE_DATE
    , he.*
  from hrm_person_master_v1 pm
    , hrm_education he
where pm.person_id    = he.person_id
order by pm.DEPT_CODE
;
