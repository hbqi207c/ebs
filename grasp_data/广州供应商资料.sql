--58笔
--值列表：地址及银行的国家、省份，付款条件
--公司名称：GY所有，GI有交易过的(GY、GI的其他信息有区别吗)
--联系人有多个，1项次和其他有区分别
--内部供应商，需人工剔除
select a.ven_no 供应商编号,
       a.ven_name 供应商名称,
       a.ven_abbr 供应商简称,
       '' 供应商英文名,
       a.foreign 是否国外供应商,
       a.ven_addr_3 邮寄地址,
       '螺丝外购/加工' 供应商类型,
       decode(a.iden_type,'03','Y<请修正>','N') 是否内部供应商,
       'C' 供应商级别,
       '中国' 国家,
       '<请按值列表输入>' 省份,
       '<需手工输入>' 城市,
       a.ven_addr_1 详细地址,
       to_char(a.zip_code) 邮编,
       '<需手工输入,建议用城市名称,注意同厂商、业务目的下不允许重复>' 地点名称,
       '采购、付款' 地点用途,
       --decode(a.brn_id, 'CJSYZF','BYZ') 公司名称,
       'GZ' 公司名称,
       b.contact_man 联系人,
       b.title 职称,
       b.tel_no 电话号码,
       b.extension 分机,
       b.cell_phone 手机号码,
       b.fax_no 传真号码,
       b.e_mail 电子邮件,
       decode(a.curr_no,'RMB','CNY',a.curr_no) 发票币种代码,
       '中国' 供应商银行国家,
       '<需手工输入>' 供应商银行名称,
       c.bank_no 供应商银行分行名称,
       '<需手工输入,银行简称+户名+帐号后5位>' 供应商银行帐户名称,
       c.acco_no 供应商银行帐号,
       a.tax_id 纳税登记编号,
       sf_get_code_name('ATAX',a.tax_kind,2) "*默认税代码",
       sf_get_code_name('ATEM',a.price_term,2) 运费条款,

       case when a.payment_term is null then
         ''
       else
         (select t.pay_name
           from TMP_PAY_TERM_20140219@Dbl_Gemerpdb t
          where a.payment_term = t.payment_term
            and a.pay_days = t.pay_days
            and t.pay_type = 'P')
       end "付款条件(值列表)",

       
       case when sf_get_code_name('APTM',a.payment_term,2)||a.pay_days is null then ''
         else sf_get_code_name('APTM',a.payment_term,2)||a.pay_days||'天'
       end 原ERP付款条件,
       
       --'' 原ERP付款条件,
       sf_get_code_name('ACPK',a.pay_kind,2) 付款方法,
       decode(a.curr_no,'RMB','CNY',a.curr_no) 付款币种,
       decode(a.iden_type,'03','直接接收<请修正>','') 接收方式,
       '' 应付账款,
       '' 预付账款
  from ven_mast a, ven_mast_d b, (select * from ven_mast_d1 where item_no = '1') c
 where 
   --a.brn_id = b.brn_id (+)
   a.ven_no = b.ven_no (+)
   --and a.brn_id = c.brn_id (+)
   and a.ven_no = c.ven_no (+)
   --and a.brn_id in ('CJSYZF')
   --order by 17, 1
   
