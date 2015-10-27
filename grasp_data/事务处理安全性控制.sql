
--事务处理安全性控制
select ho.name                        库存组织,
       fu.user_name                   用户名,
       fu.description                 用户描述,
       hp.party_name                  员工名称,
       pav.D_ORGANIZATION_ID          部门,
       h.transaction_type_name        事务处理类型,
       h.description                  事务处理类型说明,
       h.transaction_source_type_name 来源类型,
       l.segment1,
       l.description
  from apps.cux_inv_txn_type_users_all a,
       apps.fnd_user                   fu,
       apps.hz_parties                 hp,
       apps.cux_inv_txn_type_headers_v h,
       apps.cux_inv_txn_type_lines_v   l,
       apps.PER_PEOPLE_V7              ppv,
       apps.PER_ASSIGNMENTS_V7         pav,
       apps.HR_ORGANIZATION_UNITS_V    ho
 where a.user_id = fu.user_id
   and fu.person_party_id = hp.party_id
   and h.type_user_id = a.type_user_id
   and h.header_id = l.header_id
   and pav.person_id = ppv.person_id
   and fu.employee_id = ppv.person_id
   and a.organization_id = ho.organization_id
   and a.VALID_FLAG = 'Y'
   and (h.invalid_date is null or
       to_char(h.invalid_date, 'yyyymmdd') > to_char(sysdate , 'yyyymmdd'))
   and (l.invalid_date is null or
       to_char(l.invalid_date, 'yyyymmdd') > to_char(sysdate , 'yyyymmdd'))
   and a.organization_id in (145 , 146)
