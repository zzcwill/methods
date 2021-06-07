-- leetcode数据库
-- 176
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;

-- 620
SELECT * 
FROM cinema
WHERE description <> 'boring'
      and (id%2) = 1
ORDER BY rating DESC;

select *
from cinema
where mod(id, 2) = 1 and description != 'boring'
order by rating DESC;

-- 181
SELECT a.Name as Employee
FROM Employee as a,
     Employee as b
WHERE a.ManagerId = b.id AND a.Salary > b.Salary;

-- 183
SELECT a.Name as Customers
FROM Customers as a
WHERE a.Id not in (SELECT CustomerId as Id  FROM Orders);

-- 196-n
DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id;


-- 1179-n
select id,
    sum(case month when 'Jan' then revenue end) as Jan_Revenue,
    sum(case month when 'Feb' then revenue end) as Feb_Revenue,
    sum(case month when 'Mar' then revenue end) as Mar_Revenue,
    sum(case month when 'Apr' then revenue end) as Apr_Revenue,
    sum(case month when 'May' then revenue end) as May_Revenue,
    sum(case month when 'Jun' then revenue end) as Jun_Revenue,
    sum(case month when 'Jul' then revenue end) as Jul_Revenue,
    sum(case month when 'Aug' then revenue end) as Aug_Revenue,
    sum(case month when 'Sep' then revenue end) as Sep_Revenue,
    sum(case month when 'Oct' then revenue end) as Oct_Revenue,
    sum(case month when 'Nov' then revenue end) as Nov_Revenue,
    sum(case month when 'Dec' then revenue end) as Dec_Revenue
from Department
group by id;

-- 197
SELECT
    weather.id AS 'Id'
FROM
    weather
        JOIN
    weather w ON DATEDIFF(weather.recordDate, w.recordDate) = 1
        AND weather.Temperature > w.Temperature;


