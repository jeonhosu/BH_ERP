declare 
  v_string      varchar2(1000);
  
  v_overtime    number := 10;
  v_timepay     number := 2;
  
  v_using       varchar2(1000);
  
begin

   v_string := 'select :over_time * (1.5 + :timepay) as ot_amount from dual ';
--   v_string := 'select 2 * 1.5 * 1 as ot_amount from dual';
   dbms_output.put_line(v_string);
  
  v_using := 'v_overtime, v_timepay';
   
  /*v_string := replace(v_string, 'over_time', '|| :v_overtime ||' );
  dbms_output.put_line(v_string);
      */
   execute immediate v_string   
     into v_timepay
    using in v_overtime;
  dbms_output.put_line(v_timepay);
  
end;
