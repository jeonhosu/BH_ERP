-- 전표 문서번호 수정.
SELECT *
  FROM FI_DOCUMENT_NUM DN
;

SELECT *
  FROM FI_DOCUMENT_NUM_HISTORY DNH
WHERE DNH.DOCUMENT_TYPE        = 'CL'   
  AND DNH.DATE_TYPE_VALUE      = '201105'
FOR UPDATE  
;

/*
'GL-201105-1550'  --> CL-201105-006
, 'GL-201105-1553'  --> CL-201105-007
, 'GL-201105-1554'  --> CL-201105-008
*/

select *
  from fi_slip_header sh
where sh.gl_num in ('GL-201105-1554') 
   
FOR UPDATE
;

select *
  from fi_slip_LINE sh
where sh.gl_num in ('GL-201105-1554')

FOR UPDATE
;

----------------------------------------------------------------
select *
  from fi_slip_header sh
where sh.gl_num in ('CL-201105-008')  

FOR UPDATE
;

select *
  from fi_slip_LINE sh
where sh.gl_num in ('CL-201105-008')  

FOR UPDATE
;
