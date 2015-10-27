--物料类别，类别说明，物料编码，物料说明，21码，镀别，头标，单位，包装方式，包装方式说明
SELECT T.CATEGORY_CONCAT_SEGS,
       C.DESCRIPTION,
       d.item_number,
       d.item_description,
       d.segment9,
       d.segment10,
       d.segment11,
       d.segment12,
       d.segment14,
       d.segment15,
       d.primary_uom_code,
       d.segment7,
       ( select description
          from cux.cux_inv_pack_all
         where pac_code = d.segment7) pac_code_name
--d.item_number,

  FROM apps.mtl_item_categories_v  t,
       apps.MTL_CATEGORIES_V       C,
       APPS.CUX_INV_ITEM_DETAILS_V d
 WHERE C.CATEGORY_ID = T.CATEGORY_ID
   AND t.category_set_name = 'GY.销售调价类别集'
   AND T.ORGANIZATION_ID = 144
   and d.inventory_id = t.INVENTORY_ITEM_ID
   and d.item_number like '13%'
 order by d.item_number
