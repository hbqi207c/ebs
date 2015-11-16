select t.user_name, t.emp_number, t.name, v.description, v.invalid_flag
  from apps.cux_inv_ctrl_headers_v T, apps.cux_inv_ctrl_lines_v v
 where t.HEADER_ID = v.HEADER_ID
   and emp_number in (select emp_no
                        from v_emp_mast@dbl_gemerp
                       where dept_no in ('FD', 'FD1', 'FD2' ))
