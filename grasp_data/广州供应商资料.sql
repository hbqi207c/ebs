--58��
--ֵ�б���ַ�����еĹ��ҡ�ʡ�ݣ���������
--��˾���ƣ�GY���У�GI�н��׹���(GY��GI��������Ϣ��������)
--��ϵ���ж����1��κ����������ֱ�
--�ڲ���Ӧ�̣����˹��޳�
select a.ven_no ��Ӧ�̱��,
       a.ven_name ��Ӧ������,
       a.ven_abbr ��Ӧ�̼��,
       '' ��Ӧ��Ӣ����,
       a.foreign �Ƿ���⹩Ӧ��,
       a.ven_addr_3 �ʼĵ�ַ,
       '��˿�⹺/�ӹ�' ��Ӧ������,
       decode(a.iden_type,'03','Y<������>','N') �Ƿ��ڲ���Ӧ��,
       'C' ��Ӧ�̼���,
       '�й�' ����,
       '<�밴ֵ�б�����>' ʡ��,
       '<���ֹ�����>' ����,
       a.ven_addr_1 ��ϸ��ַ,
       to_char(a.zip_code) �ʱ�,
       '<���ֹ�����,�����ó�������,ע��ͬ���̡�ҵ��Ŀ���²������ظ�>' �ص�����,
       '�ɹ�������' �ص���;,
       --decode(a.brn_id, 'CJSYZF','BYZ') ��˾����,
       'GZ' ��˾����,
       b.contact_man ��ϵ��,
       b.title ְ��,
       b.tel_no �绰����,
       b.extension �ֻ�,
       b.cell_phone �ֻ�����,
       b.fax_no �������,
       b.e_mail �����ʼ�,
       decode(a.curr_no,'RMB','CNY',a.curr_no) ��Ʊ���ִ���,
       '�й�' ��Ӧ�����й���,
       '<���ֹ�����>' ��Ӧ����������,
       c.bank_no ��Ӧ�����з�������,
       '<���ֹ�����,���м��+����+�ʺź�5λ>' ��Ӧ�������ʻ�����,
       c.acco_no ��Ӧ�������ʺ�,
       a.tax_id ��˰�ǼǱ��,
       sf_get_code_name('ATAX',a.tax_kind,2) "*Ĭ��˰����",
       sf_get_code_name('ATEM',a.price_term,2) �˷�����,

       case when a.payment_term is null then
         ''
       else
         (select t.pay_name
           from TMP_PAY_TERM_20140219@Dbl_Gemerpdb t
          where a.payment_term = t.payment_term
            and a.pay_days = t.pay_days
            and t.pay_type = 'P')
       end "��������(ֵ�б�)",

       
       case when sf_get_code_name('APTM',a.payment_term,2)||a.pay_days is null then ''
         else sf_get_code_name('APTM',a.payment_term,2)||a.pay_days||'��'
       end ԭERP��������,
       
       --'' ԭERP��������,
       sf_get_code_name('ACPK',a.pay_kind,2) �����,
       decode(a.curr_no,'RMB','CNY',a.curr_no) �������,
       decode(a.iden_type,'03','ֱ�ӽ���<������>','') ���շ�ʽ,
       '' Ӧ���˿�,
       '' Ԥ���˿�
  from ven_mast a, ven_mast_d b, (select * from ven_mast_d1 where item_no = '1') c
 where 
   --a.brn_id = b.brn_id (+)
   a.ven_no = b.ven_no (+)
   --and a.brn_id = c.brn_id (+)
   and a.ven_no = c.ven_no (+)
   --and a.brn_id in ('CJSYZF')
   --order by 17, 1
   
