select --decode(a.brn_id, 'CJSYZF','BYZ') 公司,
 'GZ' 公司,
 a.loc_no 货位
  from loc_trad_m a
 where a.stop_yn = 'N'
--and a.brn_id in ('CJSYZF')
--order by 1, 2
