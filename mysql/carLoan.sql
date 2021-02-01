

SELECT 
	'客户经理控制提醒' control_message_type,
	LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"您经办的业务，',
		t.content, 
		' 存在以上风险情况，已暂停您的请款权限！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.user_id,'}' 
	),"ftcs-@20200707#%")))   as a ,
	concat(
		'{"messageContent":"您经办的业务，',
		t.content,
		' 存在以上风险情况，已暂停您的请款权限！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.user_id,'}' 
	)    as  content,
	md5(CONCAT(md5(LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"您经办的业务，',
		t.content,
		' 存在以上风险情况，已暂停您的请款权限！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.user_id,'}' 
	),"ftcs-@20200707#%"))) ),'FTCS-cls&*C(20200710)'))as signature 
FROM 
(
SELECT
	s.customer_manager_id user_id ,
	usr.realname customer_manager_name,
	usr.company_name,
	concat(	
	ifnull(a.content, ''),
	ifnull(b.content, ''),
	if( 
	   (cc.org_id IS NOT NULL 
		OR ( cc.org_id IS NULL AND ss.rules_a_rate>=(SELECT code_id as rules_a_rate FROM `code_library` WHERE code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 )) 
	   ),ifnull(c.content, '')
	,''
	),
	if( 
	   (dd.org_id IS NOT NULL 
		OR ( dd.org_id IS NULL AND ss.rules_c_rate>=(SELECT code_id as rules_c_rate FROM `code_library` WHERE code_type LIKE 'overdueUltralimitBalanceAdvanceRate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 )) 
	   ),ifnull(d.content, '')
	,''
	)
	) content  
FROM 
(select user_id customer_manager_id from loan_risk_control group by user_id UNION 
select customer_manager_id FROM loan_overdue_ultralimit_kt  
) s 
LEFT JOIN 	loan_overdue_ultralimit_kt ss on s.customer_manager_id=ss.customer_manager_id
INNER JOIN za_admin.za_user usr ON s.customer_manager_id = usr.uid AND usr.status= 'NORMAL'
INNER JOIN code_library co1 ON usr.company_id = co1.code_id
AND co1.code_type = 'companyRiskControlSwitch'
AND co1.is_inuse = 1
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未放款:',GROUP_CONCAT(' ', customer_name, ''),' ') content
	FROM
		loan_risk_control
	WHERE
		is_bank_pay_overdue = 1
	GROUP BY
		user_id
) a ON s.customer_manager_id = a.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未抵押:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_pledge_overdue = 1
	GROUP BY
		user_id
) b ON s.customer_manager_id = b.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('当期逾期客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content  
	FROM
		loan_risk_control
	WHERE
		is_overdue = 1
	GROUP BY
		user_id
) c ON s.customer_manager_id = c.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('代偿客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_advance_overdue = 1
	GROUP BY
		user_id
) d ON s.customer_manager_id = d.user_id 
LEFT JOIN
(
SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id,
	TRUNCATE (substring_index(code_id, '-', - 1),5) AS rules_a_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)cc ON usr.company_id =cc.org_id AND ss.rules_a_rate>=cc.rules_a_rate 
LEFT JOIN
(SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id ,
	TRUNCATE(substring_index(code_id, '-', - 1),5) as rules_c_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceAdvanceRate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)dd ON usr.company_id=dd.org_id AND ss.rules_c_rate>=dd.rules_c_rate  
WHERE
	a.user_id IS NOT NULL
OR b.user_id IS NOT NULL
OR 
(
	cc.org_id IS NOT NULL 
	OR( cc.org_id IS NULL AND ss.rules_a_rate>=
	(
	SELECT code_id as rules_a_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
)
OR 
(
dd.org_id IS NOT NULL 
	OR( dd.org_id IS NULL AND ss.rules_c_rate>=
	(
	SELECT code_id as rules_c_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceAdvanceRate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
)
ORDER BY s.customer_manager_id 
) t 

-- 区分一次
UNION ALL 

SELECT   
	'区域经理管护客户经理控制提醒' control_message_type,
	LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"',
		t.content, 
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	),"ftcs-@20200707#%")))   as a ,
	concat(
		'{"messageContent":"',
		t.content,
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	)    as  content,
	md5(CONCAT(md5(LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"',
		t.content,
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	),"ftcs-@20200707#%"))) ),'FTCS-cls&*C(20200710)'))as signature 
FROM ( 
 
SELECT
	mm.manager_manager_id userid,
	concat(manager_manager_group_name,':',group_concat(DISTINCT usr.realname))   content
FROM
(select user_id customer_manager_id from loan_risk_control group by user_id UNION 
select customer_manager_id FROM loan_overdue_ultralimit_kt  
) s 
LEFT JOIN 	loan_overdue_ultralimit_kt ss on s.customer_manager_id=ss.customer_manager_id
INNER JOIN za_admin.za_user usr ON s.customer_manager_id = usr.uid
INNER JOIN code_library co1 ON usr.company_id = co1.code_id
AND co1.code_type = 'companyRiskControlSwitch'
AND co1.is_inuse = 1 
INNER JOIN 
(  

SELECT DISTINCT
	/*区域经理*/
	zu.uid manager_manager_id,
	zu.realname manager_manager_name,
	/*区域经理管护业务组*/
	zur.business_group_id manager_manager_group_id,
	grp. NAME manager_manager_group_name
FROM
	za_admin.za_role zr
INNER JOIN za_admin.za_user_role zur ON zr.id = zur.role_id
INNER JOIN za_admin.za_user zu ON zur.user_id = zu.uid AND zu.status='NORMAL'
INNER JOIN za_admin.za_organization grp ON zur.business_group_id = grp.id
WHERE
	zr.name = '区域经理'


UNION 

SELECT DISTINCT
	/*区域经理*/
	zu.uid manager_manager_id,
	zu.realname manager_manager_name,
	/*区域经理管护业务组*/
	grp.id manager_manager_group_id,
	grp. NAME manager_manager_group_name
FROM
	za_admin.za_role zr
INNER JOIN za_admin.za_user_role zur ON zr.id = zur.role_id
INNER JOIN za_admin.za_user zu ON zur.user_id = zu.uid AND zu.status='NORMAL'
INNER JOIN za_admin.za_organization grp ON zur.branch_company_id = grp.parent_id AND grp.type='BUSINESS_GROUP'
WHERE
	zr.name = '区域经理' AND zur.business_group_id=-2  
	) mm on usr.bz_group_id=mm.manager_manager_group_id
	 
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未放款:',GROUP_CONCAT(' ', customer_name, ''),' ') content
	FROM
		loan_risk_control
	WHERE
		is_bank_pay_overdue = 1
	GROUP BY
		user_id
) a ON s.customer_manager_id = a.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未抵押:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_pledge_overdue = 1
	GROUP BY
		user_id
) b ON s.customer_manager_id = b.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('当期逾期客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content  
	FROM
		loan_risk_control
	WHERE
		is_overdue = 1
	GROUP BY
		user_id
) c ON s.customer_manager_id = c.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('代偿客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_advance_overdue = 1
	GROUP BY
		user_id
) d ON s.customer_manager_id = d.user_id 
LEFT JOIN
(
SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id,
	TRUNCATE (substring_index(code_id, '-', - 1),5) AS rules_a_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)cc ON usr.company_id =cc.org_id AND ss.rules_a_rate>=cc.rules_a_rate 
LEFT JOIN
(SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id ,
	TRUNCATE(substring_index(code_id, '-', - 1),5) as rules_c_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceAdvanceRate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)dd ON usr.company_id=dd.org_id AND ss.rules_c_rate>=dd.rules_c_rate  
WHERE
	a.user_id IS NOT NULL
OR b.user_id IS NOT NULL
OR 
(
cc.org_id IS NOT NULL 
	OR( cc.org_id IS NULL AND ss.rules_a_rate>=
	(
	SELECT code_id as rules_a_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
)
OR 
(
dd.org_id IS NOT NULL 
	OR( dd.org_id IS NULL AND ss.rules_c_rate>=
	(
	SELECT code_id as rules_c_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceAdvanceRate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
)   
GROUP by  mm.manager_manager_group_id ,mm.manager_manager_id
 
)t 

UNION ALL  

SELECT   
	'公司领导管护客户经理控制提醒' control_message_type,
	LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"',
		t.content,
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	),"ftcs-@20200707#%")))   as a ,
	concat(
		'{"messageContent":"',
		t.content,
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	)    as  content,
	md5(CONCAT(md5(LOWER(HEX(AES_ENCRYPT(concat(
		'{"messageContent":"',
		t.content,
		'  以上客户经理因贷后风险已被暂停请款！","noticeKey":70070001,"noticeType":70,"pushScope":2,"userId":',t.userid,'}' 
	),"ftcs-@20200707#%"))) ),'FTCS-cls&*C(20200710)'))as signature 
FROM ( 
SELECT
	mm.manager_manager_id userid,
	concat(manager_manager_org_name,':',group_concat(DISTINCT usr.realname)) content 
	FROM 
(select user_id customer_manager_id from loan_risk_control group by user_id UNION 
select customer_manager_id FROM loan_overdue_ultralimit_kt  
) s 
LEFT JOIN 	loan_overdue_ultralimit_kt ss on s.customer_manager_id=ss.customer_manager_id
INNER JOIN za_admin.za_user usr ON s.customer_manager_id = usr.uid
INNER JOIN code_library co1 ON usr.company_id = co1.code_id
AND co1.code_type = 'companyRiskControlSwitch'
AND co1.is_inuse = 1 
INNER JOIN 
(
SELECT DISTINCT
	/*贷后主管 分公司总经理*/
	zu.uid manager_manager_id,
	zu.realname manager_manager_name,
	/*区域经理管护分公司*/
	zur.branch_company_id manager_manager_org_id,
	concat(org.short_name, '分公司') manager_manager_org_name,
	zr. NAME
FROM
	za_admin.za_role zr
INNER JOIN za_admin.za_user_role zur ON zr.id = zur.role_id
INNER JOIN za_admin.za_user zu ON zur.user_id = zu.uid
AND zu. STATUS = 'NORMAL'
INNER JOIN za_admin.za_organization org ON zur.branch_company_id = org.id
WHERE
	zr. NAME IN (
		'内勤主管',
		'分公司总经理',
		'贷后主管'
	)
ORDER BY
	zu.uid
) mm on usr.company_id=mm.manager_manager_org_id 
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未放款:',GROUP_CONCAT(' ', customer_name, ''),' ') content
	FROM
		loan_risk_control
	WHERE
		is_bank_pay_overdue = 1
	GROUP BY
		user_id
) a ON s.customer_manager_id = a.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('超期未抵押:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_pledge_overdue = 1
	GROUP BY
		user_id
) b ON s.customer_manager_id = b.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('当期逾期客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content  
	FROM
		loan_risk_control
	WHERE
		is_overdue = 1
	GROUP BY
		user_id
) c ON s.customer_manager_id = c.user_id
LEFT JOIN (
	SELECT
		user_id,
		concat('代偿客户:',GROUP_CONCAT(' ', customer_name, ''),' ') content 
	FROM
		loan_risk_control
	WHERE
		is_advance_overdue = 1
	GROUP BY
		user_id
) d ON s.customer_manager_id = d.user_id 
LEFT JOIN
(
SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id,
	TRUNCATE (substring_index(code_id, '-', - 1),5) AS rules_a_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)cc ON usr.company_id =cc.org_id AND ss.rules_a_rate>=cc.rules_a_rate 
LEFT JOIN
(SELECT
	code_id,
	substring_index(code_id, '-', 1) org_id ,
	TRUNCATE(substring_index(code_id, '-', - 1),5) as rules_c_rate
FROM
	`code_library`
WHERE
	code_type LIKE 'overdueUltralimitBalanceAdvanceRate'
AND is_inuse = 1
AND code_id LIKE '%-%'
)dd ON usr.company_id=dd.org_id AND ss.rules_c_rate>=dd.rules_c_rate  
WHERE
	a.user_id IS NOT NULL
OR b.user_id IS NOT NULL
OR 
(
cc.org_id IS NOT NULL 
	OR( cc.org_id IS NULL AND ss.rules_a_rate>=
	(
	SELECT code_id as rules_a_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceN1N2N3Rate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
)
OR 
(
dd.org_id IS NOT NULL 
	OR( dd.org_id IS NULL AND ss.rules_c_rate>=
	(
	SELECT code_id as rules_c_rate
	FROM `code_library`
	WHERE code_type LIKE 'overdueUltralimitBalanceAdvanceRate' AND is_inuse = 1 AND code_id NOT LIKE '%-%' limit 1 
	)
	) 
) 
GROUP by  mm.manager_manager_org_id  ,mm.manager_manager_id
 
)t 
