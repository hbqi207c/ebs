订单维护-收货方
/*
table_name:        表名
colume_name:       字段名
enabled_flag:      Y--能修改 N--不能修改
*/
select c.*, rowid from cux_update_column_list c
where c.colume_name = 'SHIP_TO_LOCATION'
for update
订单维护-付款条件
--EBS查看付款条件：GY应收管理超级用户->设置->事务处理->付款条件
/*
name                 付款条件
term_id              付款条件ID
*/
SELECT * from RA_TERMS_VL  --
SELECT * FROM cux_order_headers_all t WHERE t.order_number= 'F140604K-1A' FOR UPDATE --payment_term_id=term_id
订单维护-支付方式
SELECT * FROM cux_order_headers_all t WHERE t.order_number= 'F140604K-1A' FOR UPDATE --payment_type_code
