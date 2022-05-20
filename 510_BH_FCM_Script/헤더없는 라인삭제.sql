select * from fi_slip_line t
where t.gl_date            BETWEEN TO_DATE('2010-01-01', 'YYYY-MM-DD') AND to_date('2011-06-30', 'yyyy-mm-dd')
--  and t.account_code       = '5130703'
  and t.sob_id             = 10
  and not exists ( select 'x'
                 from fi_slip_header sh
               where sh.slip_header_id         = t.slip_header_id
                 and sh.sob_id                 = t.sob_id
             )
for update             
;
      
DELETE FI_SLIP_LINE SL
    WHERE SL.SLIP_HEADER_ID       =982
    ;
    
SELECT *
  FROM FI_SLIP_HEADER SL
    WHERE SL.SLIP_HEADER_ID       =891
