  --�깤���ӿ�
select *
  from cux_int_cmp_lines_v
 where flag = 'E'
   and ��error_mesg not like '%����δ���ñ�׼%'
   and error_mesg not like '%EBSϵͳû��%' ��;
   
   --
   select * from cux_int_cmp_lines_v  where SEGMENT21 like '%115102000255%'  and SEGMENT20='10'
   
   UPDATE cux_int_cmp_lines_v
   SET SEGMENT19='STOCK-GYFW1-15-1282'
   WHERE SEGMENT19='GYFW1-15-1282'
   
   --�����ӿ�
   select * from cux_int_orders_all where attribute1='GYKF3-15-NC07-25'
   
   delete from cux_int_orders_all
   where attribute1='GYKF3-15-NC07-25' and ebs_line_number='15'
   
   --���Ʒ��ί��ӿ�
   select * from cux_int_exp_headers_all where flag <> 'Y';
   
   
