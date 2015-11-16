  --完工入库接口
select * --error_mesg,segment19,segment20,item_no
  from cux_int_cmp_lines_v a
 where flag = 'E' and to_char(t_time,'YYYYMM')='201510'
   --and error_mesg like '%INVALID%'
   and （error_mesg not like '%物料未设置标准%'
   and error_mesg not like '%EBS系统没有%' ）;
   
   --
   select * from cux_int_cmp_lines_v  where flag='E' and SEGMENT21 like '%415102700033%'
   
   UPDATE cux_int_cmp_lines_v
   SET SEGMENT19='STOCK-GYFW1-15-1282'
   WHERE SEGMENT19='GYFW1-15-1282'
   
   --订单接口
   select * from cux_int_orders_all where attribute1='GYXC%'
   
   delete from cux_int_orders_all
   where attribute1='GYKF3-15-NC07-25' and ebs_line_number='15'
   
   --半成品、委外接口
   select * from cux_int_exp_headers_all where flag <> 'Y';
   
   
