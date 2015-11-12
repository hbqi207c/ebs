--值列表提供：地址、销售地区、银行的州、国家、省
--           客户组别、业务人员、服务人员、付款条件
--公司地址、邮寄地址、发票地址：放后面参考
--17家分公司客户：520（不含停用、不含内部客户）
select --decode(a.brn_id, 'CJSYZF', 'BYZ') 销售公司,
       a.cst_no 客户编码,
       a.cst_name 客户名称,
       a.cst_abbr 客户简称,
       decode(a.cst_id_kind, '02', 'Y', '03', 'Y', 'N') 是否内部客户,
       a.boss 法人代表,
       a.tel_no1 公司固定电话,
       a.act_tel_no 公司移动电话,
       a.fax_no 公司传真号码,
       a.tax_id 税号,
       '中国' "详细地址-国家",
       '<请按值列表输入>' "省(国内)",
       '<请手工输入>' "市(国内)",
       '<请手工输入>' "县/区(国内)",
       '' "省(州)(国外)",
       a.cst_addr_2 地址1,
       '' 地址2,
       '' 地址3,
       '' 地址4,
       '' 邮编,
       '<请手工输入>' 收件人,
       'Y' "业务目的1-收单方",
       '<请手工输入,城市标识,注意同客户、业务目的下不允许重复>' "业务目的1-地点名称",
       'Y' "业务目的1-是否主要",
       'Y' "业务目的2-收货方",
       '<请手工输入,城市标识,注意同客户、业务目的下不允许重复>' "业务目的2-地点名称",
       '' 关联收单地点,
       'Y' "业务目的2-是否主要",
       '亚洲' "销售区域-洲",
       '中国' "国家",
       '<请按值列表输入>' "省(州)",
       decode(b.sex, 'M', '先生', '女士') "联系人-性别:先生/女士",
       b.contact_man "联系人-姓名",
       b.tel_no "联系人-电话",
       '中国' 银行国家,
       '<请手工输入>' 银行名称,
       a.bank 银行分行名称,
       a.bank || substr(a.acco_no, -5, 5) 银行帐户名称,
       a.acco_no 银行帐号,
       '' "应收帐款（代码）",
       '' "销售收入（代码）",
       '' "预收帐款（代码）",
       sf_get_csttype_name(a.type_no, 2) 客户形态,
       '' 客户忠诚度,
       a.cst_class 客户等级,
       /*
       sf_get_brn_abbr(a.brn_id, 2) "客户组别(值列表)",
       */
       '' "客户组别(值列表)",
       decode(a.currency, 'RMB', 'CNY', a.currency) 币种,
       a.credit * 3 未提货信用额度,
       a.credit 未付款信用额度,
       a.sale_kind 行业类型,
       decode(a.sal_status,
              'A',
              '良好',
              'B',
              '普通',
              'C',
              '不佳',
              'D',
              '关闭',
              a.sal_status) 经营状况,
       sf_get_code_name('ABRN', a.cst_id_kind, 2) 客户身份,
       sf_get_emp_name(a.sale_no, 2) "业务负责人(值列表)",
       '<请按值列表输入>' "服务人员(值列表)",
       sf_get_code_name('ACPK', a.pay_kind, 2) "支付方式(值列表)",
       
       case
         when a.payment_term is null then
          ''
         when a.payment_term = '03' then
          (select t.pay_name
             from TMP_PAY_TERM_20140219@dbl_gemerpdb t
            where a.payment_term = t.payment_term
              and a.pay_days = t.pay_days
              and a.date_kind = t.date_kind
              AND t.pay_type = 'C')
         else
          (select t.pay_name
             from TMP_PAY_TERM_20140219 t
            where a.payment_term = t.payment_term
              and a.pay_days = t.pay_days
              AND t.pay_type = 'C')
       end "付款条件(值列表)",
       
       --'' "付款条件(值列表)",
       
       case
         when sf_get_code_name('APTM', a.payment_term, 2) || a.pay_days is null then ''
         else sf_get_code_name('APTM', a.payment_term, 2) || a.pay_days || '天' ||a.date_kind || '日结'
       end  原ERP付款条件,
       '' 客户价目表,
       sf_get_code_name('BDTR', a.deli_method, 2) 发运方法,
       '含运费' 运费条款,
       'VAT-17-O' 税率,
       '5%' 运费比率,
       a.first_ex_date 最初交易日期,
       0 "线架借用额度（个）",
       'N' 是否集团型客户,
       '' 上级单位,
       'N' 是否预测客户,
       a.consignment_yn 是否寄售客户,
       '<请手工输入>' 是否一般纳税人,
       '0' 订单交期最小天数,
       '9999' 订单交期最大天数,
       a.cst_addr_1 "供参考-公司地址",
       a.cst_addr_3 "供参考-邮寄地址",
       a.cst_addr_2 "供参考-发票地址"
  from cst_mast a, (select * from cst_mast_d1 where seq = '1') b
 where 
   --a.brn_id = b.brn_id(+)
   a.cst_no = b.cst_no(+)
   --and a.brn_id in ('CJSYZF')
   and a.stop_yn = 'N'
   and a.cst_id_kind not in ('02', '03') --内部客户不需要再整理
   --order by 1, 2
