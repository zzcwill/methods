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


-- 1179-n-分组转换
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

-- 197-n-昨天
SELECT
    weather.id AS 'Id'
FROM
    weather
        JOIN
    weather w ON DATEDIFF(weather.recordDate, w.recordDate) = 1
        AND weather.Temperature > w.Temperature;

-- 596
SELECT class 
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- 178-n
SELECT 
Score,
dense_rank() over (order by Score desc)  as 'Rank'
-- 不指定 partition by 相当于所有行数据一个 partition, 数据进行区内排序
-- dense_rank() 相当于每一行数据一个窗口, 对数据进行比较
FROM Scores;

-- 177-n
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N := N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT 
            salary
      FROM 
            employee
      GROUP BY 
            salary
      ORDER BY 
            salary DESC
      LIMIT N, 1
  );
END

-- 626-n
SELECT
    (CASE
        WHEN MOD(id, 2) != 0 AND counts != id THEN id + 1
        WHEN MOD(id, 2) != 0 AND counts = id THEN id
        ELSE id - 1
    END) AS id,
    student
FROM
    seat,
    (SELECT
        COUNT(*) AS counts
    FROM
        seat) AS seat_counts
ORDER BY id ASC;

-- 184-n
SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    );

-- 180-n
SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;

-- 262-n








