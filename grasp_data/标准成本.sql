--根据物料编码查找含税单价（unit_price ），把物料编码和含税单价给财务建成本
--取unit_price为含税单价
SELECT * FROM cux.cux_po_lines_all t WHERE t.item_no = ''
