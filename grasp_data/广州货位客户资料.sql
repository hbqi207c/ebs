--ֵ�б��ṩ����ַ�����۵��������е��ݡ����ҡ�ʡ
--           �ͻ����ҵ����Ա��������Ա����������
--��˾��ַ���ʼĵ�ַ����Ʊ��ַ���ź���ο�
--17�ҷֹ�˾�ͻ���520������ͣ�á������ڲ��ͻ���
select --decode(a.brn_id, 'CJSYZF', 'BYZ') ���۹�˾,
       a.cst_no �ͻ�����,
       a.cst_name �ͻ�����,
       a.cst_abbr �ͻ����,
       decode(a.cst_id_kind, '02', 'Y', '03', 'Y', 'N') �Ƿ��ڲ��ͻ�,
       a.boss ���˴���,
       a.tel_no1 ��˾�̶��绰,
       a.act_tel_no ��˾�ƶ��绰,
       a.fax_no ��˾�������,
       a.tax_id ˰��,
       '�й�' "��ϸ��ַ-����",
       '<�밴ֵ�б�����>' "ʡ(����)",
       '<���ֹ�����>' "��(����)",
       '<���ֹ�����>' "��/��(����)",
       '' "ʡ(��)(����)",
       a.cst_addr_2 ��ַ1,
       '' ��ַ2,
       '' ��ַ3,
       '' ��ַ4,
       '' �ʱ�,
       '<���ֹ�����>' �ռ���,
       'Y' "ҵ��Ŀ��1-�յ���",
       '<���ֹ�����,���б�ʶ,ע��ͬ�ͻ���ҵ��Ŀ���²������ظ�>' "ҵ��Ŀ��1-�ص�����",
       'Y' "ҵ��Ŀ��1-�Ƿ���Ҫ",
       'Y' "ҵ��Ŀ��2-�ջ���",
       '<���ֹ�����,���б�ʶ,ע��ͬ�ͻ���ҵ��Ŀ���²������ظ�>' "ҵ��Ŀ��2-�ص�����",
       '' �����յ��ص�,
       'Y' "ҵ��Ŀ��2-�Ƿ���Ҫ",
       '����' "��������-��",
       '�й�' "����",
       '<�밴ֵ�б�����>' "ʡ(��)",
       decode(b.sex, 'M', '����', 'Ůʿ') "��ϵ��-�Ա�:����/Ůʿ",
       b.contact_man "��ϵ��-����",
       b.tel_no "��ϵ��-�绰",
       '�й�' ���й���,
       '<���ֹ�����>' ��������,
       a.bank ���з�������,
       a.bank || substr(a.acco_no, -5, 5) �����ʻ�����,
       a.acco_no �����ʺ�,
       '' "Ӧ���ʿ���룩",
       '' "�������루���룩",
       '' "Ԥ���ʿ���룩",
       sf_get_csttype_name(a.type_no, 2) �ͻ���̬,
       '' �ͻ��ҳ϶�,
       a.cst_class �ͻ��ȼ�,
       /*
       sf_get_brn_abbr(a.brn_id, 2) "�ͻ����(ֵ�б�)",
       */
       '' "�ͻ����(ֵ�б�)",
       decode(a.currency, 'RMB', 'CNY', a.currency) ����,
       a.credit * 3 δ������ö��,
       a.credit δ�������ö��,
       a.sale_kind ��ҵ����,
       decode(a.sal_status,
              'A',
              '����',
              'B',
              '��ͨ',
              'C',
              '����',
              'D',
              '�ر�',
              a.sal_status) ��Ӫ״��,
       sf_get_code_name('ABRN', a.cst_id_kind, 2) �ͻ����,
       sf_get_emp_name(a.sale_no, 2) "ҵ������(ֵ�б�)",
       '<�밴ֵ�б�����>' "������Ա(ֵ�б�)",
       sf_get_code_name('ACPK', a.pay_kind, 2) "֧����ʽ(ֵ�б�)",
       
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
       end "��������(ֵ�б�)",
       
       --'' "��������(ֵ�б�)",
       
       case
         when sf_get_code_name('APTM', a.payment_term, 2) || a.pay_days is null then ''
         else sf_get_code_name('APTM', a.payment_term, 2) || a.pay_days || '��' ||a.date_kind || '�ս�'
       end  ԭERP��������,
       '' �ͻ���Ŀ��,
       sf_get_code_name('BDTR', a.deli_method, 2) ���˷���,
       '���˷�' �˷�����,
       'VAT-17-O' ˰��,
       '5%' �˷ѱ���,
       a.first_ex_date �����������,
       0 "�߼ܽ��ö�ȣ�����",
       'N' �Ƿ����Ϳͻ�,
       '' �ϼ���λ,
       'N' �Ƿ�Ԥ��ͻ�,
       a.consignment_yn �Ƿ���ۿͻ�,
       '<���ֹ�����>' �Ƿ�һ����˰��,
       '0' ����������С����,
       '9999' ���������������,
       a.cst_addr_1 "���ο�-��˾��ַ",
       a.cst_addr_3 "���ο�-�ʼĵ�ַ",
       a.cst_addr_2 "���ο�-��Ʊ��ַ"
  from cst_mast a, (select * from cst_mast_d1 where seq = '1') b
 where 
   --a.brn_id = b.brn_id(+)
   a.cst_no = b.cst_no(+)
   --and a.brn_id in ('CJSYZF')
   and a.stop_yn = 'N'
   and a.cst_id_kind not in ('02', '03') --�ڲ��ͻ�����Ҫ������
   --order by 1, 2
