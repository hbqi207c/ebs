select --decode(a.brn_id, 'CJSYZF','BYZ') ��˾,
 'GZ' ��˾,
 a.loc_no ��λ
  from loc_trad_m a
 where a.stop_yn = 'N'
--and a.brn_id in ('CJSYZF')
--order by 1, 2
