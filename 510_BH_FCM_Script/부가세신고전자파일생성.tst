PL/SQL Developer Test script 3.0
14
begin
  -- Call the procedure
  fi_vat_declaration_g.set_report_file(w_tax_code => :w_tax_code,
                                       w_sob_id => :w_sob_id,
                                       w_org_id => :w_org_id,
                                       w_issue_date_fr => :w_issue_date_fr,
                                       w_issue_date_to => :w_issue_date_to,
                                       p_write_date => :p_write_date,
                                       p_management_num => :p_management_num,
                                       p_tax_payer_type => :p_tax_payer_type,
                                       p_tax_refund_type => :p_tax_refund_type,
                                       p_user_id => :p_user_id,
                                       o_message => :o_message);
end;
11
w_tax_code
1
ï»?10
5
w_sob_id
1
20
4
w_org_id
1
201
4
w_issue_date_fr
1
2011-04-01
12
w_issue_date_to
1
2011-06-30
12
p_write_date
1
2011-07-21
12
p_management_num
0
5
p_tax_payer_type
1
ï»?
5
p_tax_refund_type
1
ï»?
5
p_user_id
1
100
4
o_message
0
5
0
