-- 多条联查-查询用户-已办贷款任务
SELECT
 	-- COUNT(*) as total
	c.*,
	b.node_key,
	b.node_name,
	b.business_type	
FROM
   za_admin.za_user  a 
  --  INNER JOIN 
	 LEFT JOIN
   cls.business_object_process_info  b     on    a.uid = b.operator_id
   INNER JOIN 
   cls.loan_project_info   c     on        b.business_object_id = c.id
WHERE
	a.uid = 827  AND
	b.is_finished = 1 AND
	b.business_type = 'CREDIT_FLOW'
  b.borrower_name LIKE '王%'
ORDER BY c.id ASC
	LIMIT 1000
	OFFSET 0; 