CREATE OR REPLACE VIEW HRD_DAY_INTERFACE_V
(person_id, work_date, work_corp_id, corp_id, dept_id, post_id, job_category_id, work_type_id, duty_id, holy_type, open_time, close_time, open_time1, close_time1, next_day_yn, leave_id, leave_time_code, modify_yn, modify_in_yn, modify_out_yn, modify_flag, approved_yn, approved_date, approved_person_id, confirmed_yn, confirmed_date, confirmed_person_id, approve_status, trans_yn, trans_date, trans_person_id, description, sob_id, org_id, created_by, last_update_date, last_updated_by, plan_open_time, plan_close_time, before_ot_start, before_ot_end, after_ot_start, after_ot_end, lunch_yn, dinner_yn, midnight_yn, dangjik_yn, all_night_yn, work_type_group, person_check_yn, person_check_date, person_check_by, 
reject_remark, reject_yn, reject_date, reject_person_id, T_DUTY_ID,T_DUTY_DESC)
AS
SELECT                      /*+ INDEX(HRD_DAY_INTERFACE HRD_DAY_INTERFACE_U1) */
            di.person_id,
             di.work_date,
             di.work_corp_id,
             di.corp_id,
             di.dept_id,
             di.post_id,
             di.job_category_id,
             NVL (di.work_type_id, wc.work_type_id) AS work_type_id,
             NVL (wc.c_duty_id1, NVL (wc.c_duty_id, di.duty_id)) duty_id,
             NVL (wc.holy_type, di.holy_type) AS holy_type,
             di.open_time,
             di.close_time,
             di.open_time1,
             di.close_time1,
             di.next_day_yn,
             di.leave_id,
             di.leave_time_code,
             di.modify_yn,
             di.modify_in_yn,
             di.modify_out_yn,
             CASE
                 WHEN di.modify_yn = 'Y' THEN 'Y'
                 WHEN di.modify_in_yn = 'Y' THEN 'Y'
                 WHEN di.modify_out_yn = 'Y' THEN 'Y'
                 ELSE 'N'
             END
                 modify_flag,
             di.approved_yn,
             di.approved_date,
             di.approved_person_id,
             di.confirmed_yn,
             di.confirmed_date,
             di.confirmed_person_id,
             di.approve_status,
             NVL (di.trans_yn, 'N') AS trans_yn,
             di.trans_date,
             di.trans_person_id,
             di.description,
             di.sob_id,
             di.org_id,
             di.created_by,
             di.last_update_date,
             di.last_updated_by,
             wc.open_time AS plan_open_time,
             wc.close_time AS plan_close_time,
             wc.before_ot_start,
             wc.before_ot_end,
             wc.after_ot_start,
             wc.after_ot_end,
             wc.lunch_yn,
             wc.dinner_yn,
             wc.midnight_yn,
             wc.dangjik_yn,
             wc.all_night_yn,
             wc.attribute5 AS work_type_groupk,
             di.person_check_yn,
             di.person_check_date,
             di.person_check_by,
             DI.REJECT_REMARK,
             DI.REJECT_YN,
             DI.REJECT_DATE,
             DI.REJECT_PERSON_ID, 
             T_DUTY_ID,		
             T_DUTY_DESC
      FROM hrd_day_interface di, hrd_work_calendar wc
     WHERE      di.person_id = wc.person_id(+)
             AND di.work_date = wc.work_date(+)
             AND di.sob_id = wc.sob_id(+)
             AND di.org_id = wc.org_id(+);
