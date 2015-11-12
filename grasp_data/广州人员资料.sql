--广州人员资料
select a.corp_no 公司代号,
       sf_hr_get_code_name('CORP', a.corp_no, 2) 公司名称,
       a.emp_no 工号,
       a.emp_name_c 姓名,
       a.sex 性别代号,
       decode(a.sex, '1', '男', '女') 性别,
       a.dept_no 部门代号,
       sf_get_dept_abbr(a.dept_no, 2) 部门名称,
       a.duty 职务代号,
       sf_hr_get_code_name('DUTY', a.duty, 2) 职务,
       '<请手工输入Y/N>' 操作员否,
       '<请手工输入姓名,审批用的上级主管>' 上级主管
  from emp_mast a
 where a.qdate is null 
 -- and sf_get_dept_abbr(a.dept_no,2) like '%扬州%'
 order by 1 desc, 7, 9, 3
