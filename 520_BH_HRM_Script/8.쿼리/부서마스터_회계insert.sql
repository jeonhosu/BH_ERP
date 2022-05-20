select *
  from hrm_dept_master  x
where x.corp_id         = 65
order by x.dept_id
;

select *
  from fi_account_book x
where x.account_book_id = 1
;

select *
  from fi_dept_master x
where x.sob_id        = 10
--for update
;

insert into fi_dept_master 
( dept_id, sob_id
, dept_code, dept_name
, dept_level, upper_dept_id
, sort_num, dept_group
, description
, enabled_flag
, effective_date_fr, effective_date_to
, creation_date, created_by, last_update_date, last_updated_by
)
select 
     fi_dept_master_s1.nextval, sob_id
    , dept_code, dept_name
    , dept_level, upper_dept_id
    , dept_sort_num, dept_group
    , description
    , usable
    , start_date, end_date
    , to_date('2010-12-15 19:00:00', 'yyyy-mm-dd hh24:mi:ss'), 50
    , to_date('2010-12-15 19:00:00', 'yyyy-mm-dd hh24:mi:ss'), 50
  from hrm_dept_master dm
where dm.corp_id       = 65
  and dm.sob_id        = 10
  and dm.org_id        = 101
--order by dept_id  
;

-- ºÎ¼­¸ÊÇÎ.
select *
  from hrm_dept_mapping dm
;

-- ºÎ¼­ ¸ÊÇÎ.
INSERT INTO HRM_DEPT_MAPPING 
( MODULE_TYPE, HR_DEPT_ID, CORP_ID
, M_DEPT_ID
, ENABLED_FLAG, EFFECTIVE_DATE_FR
, SOB_ID, ORG_ID
, CREATION_DATE, CREATED_BY
, LAST_UPDATE_DATE, LAST_UPDATED_BY
)
SELECT 'FCM' AS MODULE_TYPE
     , DM.DEPT_ID
     , DM.CORP_ID
     , FDM.DEPT_ID
     , 'Y'
     , TO_DATE('2010-11-01', 'YYYY-MM-DD')
     , DM.SOB_ID
     , DM.ORG_ID
     , TO_DATE('2010-11-01 18:18:18', 'YYYY-MM-DD HH24:MI:SS')
     , 20
     , TO_DATE('2010-11-01 18:18:18', 'YYYY-MM-DD HH24:MI:SS')
     , 20
  FROM HRM_DEPT_MASTER DM
    , FI_DEPT_MASTER FDM
WHERE DM.DEPT_CODE                = FDM.DEPT_CODE
  AND DM.SOB_ID                   = FDM.SOB_ID
  AND DM.CORP_ID                  = 65
  AND DM.SOB_ID                   = 10
  AND DM.ORG_ID                   = 101
  AND DM.DEPT_LEVEL               = 4
;
