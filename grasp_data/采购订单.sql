--采购订单资料
SELECT S.ORG_ID,
       ( SELECT A.NAME
          FROM APPS.HR_ALL_ORGANIZATION_UNITS A, APPS.HR_LOCATIONS B
         WHERE A.LOCATION_ID = B.LOCATION_ID
           AND A.ORGANIZATION_ID = S.ORG_ID) ORG_NAME,
       ( SELECT VENDOR_NAME
          FROM APPS.PO_VENDORS
         WHERE VENDOR_ID = S.VENDOR_ID) VENDOR_NAME,
       S.PO_DATE,
       S.PO_NUMBER,
       V.ITEM_NO,
       --S.VENDOR_ID,
       V.UNIT_PRICE,
       V.LINE_QTY,
       (V.LINE_QTY * V.UNIT_PRICE) AMOUNT,
       V.ITEM_NAME,
       S.COMMENTS,
       S.SOURCE_PO_ORG_NAME,
       S.SOURCE_PO_NUMBER
--S.CATEGORY_CODE,
--(SELECT meaning FROM  apps.fnd_common_lookups WHERE lookup_type = 'ITEM_TYPE' AND lookup_code=s.category_code) CATEGORY_name,
--v.ITEM_NAME，
--v.COMMENTS
  FROM APPS.CUX_PO_HEADERS_V7 S, APPS.CUX_PO_LINES_ALL V
 WHERE S.HEADER_ID = V.HEADER_ID
   AND S.STATUS_CODE = 'APPROVED'
      --AND S.ORG_ID IN('81')
   AND V.ITEM_NAME LIKE '%吊环%'
--AND (SELECT meaning FROM  apps.fnd_common_lookups WHERE lookup_type = 'ITEM_TYPE' AND lookup_code=s.category_code) ='委外维修'
--AND item_no LIKE '33%'
--AND agent_id='464'
--AND S.PO_NUMBER='1120140801544'
--AND v.ITEM_NAME LIKE '%汽车%'
