
-- 经典sql练习题
-- 1
SELECT name FROM test GROUP BY name HAVING min(grade) >= 80;

-- 2
DELETE FROM test WHERE id NOT IN (
	SELECT MIN(id) as id FROM 
	(SELECT * FROM test) as table1
	GROUP BY table1.name, table1.course, table1.grade
);

-- 3
SELECT a.name as one, b.name as two
FROM test3 a, test3 b
WHERE a.name < b.name


-- 4
SELECT a.*
FROM test4 a,
		(
			SELECT month, max(money) as money 
			FROM test4
			WHERE name='a'
			GROUP BY month
		) b
WHERE a.month = b.month AND a.money > b.money

-- 5
SELECT 
	year,
	(SELECT amount FROM test5 m WHERE month=1 AND m.year=test5.year) as m1,
	(SELECT amount FROM test5 m WHERE month=2 AND m.year=test5.year) as m2
FROM test5
GROUP BY year;

-- 6
SELECT 
	p_id,
	(SELECT num_id FROM test6 m WHERE s_id=1 AND m.p_id = test6.p_id) as s1_num,
	(SELECT num_id FROM test6 m WHERE s_id=2 AND m.p_id = test6.p_id) as s2_num
FROM test6
GROUP BY p_id

-- 正题
-- 1
SELECT s.*, a.score as score_01, b.score as score_02
FROM student s,
     (SELECT sid, score FROM sc WHERE cid=01) a,
     (SELECT sid, score FROM sc WHERE cid=02) b
WHERE a.sid = b.sid AND a.score > b.score AND s.sid = a.sid

-- 2
SELECT min(s.sid) as sid, min(sname) as sname, avg(score) as avg_score
FROM student as s, sc
WHERE s.sid = sc.sid
GROUP BY s.sid
HAVING avg_score > 60

-- 3