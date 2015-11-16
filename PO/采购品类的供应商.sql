SELECT V1.ORG_ID,
       V1.ORG_NAME,
       V1.ORG_TYPE_NAME,
       V2.CATEGORY_NAME,
       V2.APPROVE_ORG_NAME,
       V2.DISABLED_FLAG,
       V3.VENDOR_NAME,
       V3.DATE_FROM,
       V3.DATE_TO
  FROM APPS.CUX_PO_SEC_CONTROL_HEADERS_V V1,
       apps.CUX_PO_SEC_CONTROL_LINES_V   V2,
       apps.CUX_PO_SEC_CONTROL_VENDORS_V V3
 WHERE v1.header_id = v2.header_id
   AND v2.line_id = v3.line_id
   AND v1.org_id NOT IN ('81', '82')
