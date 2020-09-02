-- 单表查-查询客户量
SELECT 
  *
FROM
 customer_base_info
WHERE
 YEAR(create_time) = 2020 AND
 DATE_FORMAT(create_time,'%Y-%m-%d') > '2020-06-06'

-- 查询客户量-优化写法-性能好
-- 运算符号前不要用函数
-- 不要用*
-- 不要用不等号
SELECT 
 customer_no,
 customer_name,
 cert_type,
 cert_no,
 mobile_phone
FROM
 customer_base_info
WHERE
create_time > '2020-06-06' AND 
create_time < '2020-12-31 24:00:00' AND
customer_name LIKE '王%'
 