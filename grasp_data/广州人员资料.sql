--������Ա����
select a.corp_no ��˾����,
       sf_hr_get_code_name('CORP', a.corp_no, 2) ��˾����,
       a.emp_no ����,
       a.emp_name_c ����,
       a.sex �Ա����,
       decode(a.sex, '1', '��', 'Ů') �Ա�,
       a.dept_no ���Ŵ���,
       sf_get_dept_abbr(a.dept_no, 2) ��������,
       a.duty ְ�����,
       sf_hr_get_code_name('DUTY', a.duty, 2) ְ��,
       '<���ֹ�����Y/N>' ����Ա��,
       '<���ֹ���������,�����õ��ϼ�����>' �ϼ�����
  from emp_mast a
 where a.qdate is null 
 -- and sf_get_dept_abbr(a.dept_no,2) like '%����%'
 order by 1 desc, 7, 9, 3
