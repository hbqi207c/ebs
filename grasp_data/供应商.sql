--供应商
SELECT A.VENDOR_ID, A.VENDOR_NAME
  FROM APPS.PO_VENDORS A, APPS.PO_VENDOR_SITES_ALL B
 WHERE A.VENDOR_ID = B.VENDOR_ID
   AND B.ORG_ID = 81
--AND A.VENDOR_NAME LIKE '%晋吉%' --3005
