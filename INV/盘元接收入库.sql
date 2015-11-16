/*
FORM:盘元线材接收入库
栏位：材质、盘径、棒料、炉号、厂牌、进货单号、进货日期、卷数、重量
*/
SELECT S.ITEM_NO          物料编码,
       SEGMENT10          材质,
       SEGMENT11          线径,
       SEGMENT13          棒料,
       S.FURNACE_NO       炉号,
       T.VENDOR_NUMBER    厂牌,
       T.VENDOR_NAME,
       T.RCV_NUMBER       入库单号,
       T.TRANSACTION_DATE 入库日期,
       S.RCV_COILS_COUNT  卷数,
       S.RCV_COILS_QTY    重量,
       S.RCV_QTY          数量
  FROM APPS.CUX_PO_RCV_COIL_HEADERS_V T,
       APPS.CUX_PO_RCV_COIL_LINES_V   S,
       APPS.CUX_INV_ITEM_DETAILS_V    V
 WHERE T.RCV_HEADER_ID = S.RCV_HEADER_ID
   AND S.ITEM_NO = V.ITEM_NUMBER
   AND T.ORG_ID = '81'
   AND TO_CHAR(T.TRANSACTION_DATE, 'YYYYMM') = '201410'
 ORDER BY T.RCV_NUMBER
