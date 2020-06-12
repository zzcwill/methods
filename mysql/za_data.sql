SELECT
  main.collector collector,
  cust.cust_name,
  batch.OA_ORG_ID,
  main.case_id,
  main.case_amt case_amt,
  cust.mcard_mobile AS phone,
  1 AS is_valid,
  'SYSTEM' AS upd_user,
  curdate() AS bt_date
FROM
  tbl_ccms_biz_case_main main
LEFT JOIN tbl_ccms_biz_acct_account acct ON main.case_id = acct.case_id
INNER JOIN tbl_ccms_biz_oa_batch batch ON acct.oa_batch_no = batch.oa_batch_no
AND batch.PRED_BACK_CASE_DATE >= CURDATE()
AND batch.OA_ORG_ID <> 'ZAHY'
LEFT JOIN tbl_ccms_biz_cust_customer cust ON main.cust_no = cust.cust_no
INNER JOIN (
  SELECT
    case_id,
    act_code,
    crt_time
  FROM
    (
      SELECT
        case_id,
        act_code,
        crt_time
      FROM
        `tbl_ccms_log_act_action`
      ORDER BY
        crt_time DESC
      LIMIT 0,
      1234567890
    ) s
  GROUP BY
    case_id
) action ON main.case_id = action.case_id
AND action.act_code IN ('CXWJT', 'JJJT','WFW','OFF')
AND action.crt_time >= date_sub(CURDATE(), INTERVAL 7 day)
AND action.crt_time < CURDATE()