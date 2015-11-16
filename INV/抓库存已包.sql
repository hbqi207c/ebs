--抓库存已包
--FORM:BARCODE信息查询
SELECT U.ITEM_NO          物料号,
       W.SEGMENT9,
       W.SEGMENT10,
       W.SEGMENT11,
       W.SEGMENT12,
       W.SEGMENT14        镀别,
       W.SEGMENT15        头标,
       U.lot_number       批号,
       W.item_description 描述,
       U.QUANTITY         数量,
       U.FCL_QTY          箱数,
       T.TARE_WEIGHT      重量,
       T.CUX_ORDER_NUMBER 订单号,
       T.BARCODE          条码号,
       T.SUBINVENTORY     子库存,
       T.SYS_LOCATOR      货位
--T.CUX_ORDER_NUMBER,
--U.PER_CASE_QTY
  FROM APPS.CUX_INV_BARCODES_V     T,
       APPS.CUX_INV_BARCODE_LOTS_V U,
       APPS.CUX_INV_ITEM_DETAILS_V W
 WHERE （(W.SEGMENT9 = 'ABOE'
       AND W.SEGMENT10 LIKE 'AI%')
    OR (W.SEGMENT9 = 'ABOE' AND W.SEGMENT10 LIKE 'BI%' )
    OR (W.SEGMENT9 = 'BOE' AND W.SEGMENT10 LIKE 'AI%' )
    OR (W.SEGMENT9 = 'BOE' AND W.SEGMENT10 LIKE 'BI%' )
 ）
   AND T.ORGANIZATION_ID = '145'
   AND U.ORGANIZATION_ID = '145'
   AND T.pdc_id = U.pdc_id
   AND U.ITEM_NO = W.ITEM_NUMBER
--单抓数量可以这样抓
  SELECT V.*, C.*
          FROM APPS.CUX_ONHAND_QUANTITY_V        V,
         APPS.CUX.CUX_INV_ITEM_DETAILS_ALL C
         WHERE V.INVENTORY_ITEM_ID = C.INVENTORY_ID
