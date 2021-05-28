
-- 经典sql练习题
-- 1
SELECT name FROM test GROUP BY name HAVING min(grade) >= 80;

-- 2
DELETE FROM test WHERE id NOT IN (
	SELECT id FROM 
	(SELECT * FROM test) as table1
	GROUP BY table1.name, table1.course, table1.grade
);

-- 3
SELECT a.name as one, b.name as two
FROM test3 a, test3 b
WHERE a.name < b.name;


-- 4
SELECT a.*
FROM test4 a,
		(
			SELECT month, max(money) as money 
			FROM test4
			WHERE name='a'
			GROUP BY month
		) b
WHERE a.month = b.month AND a.money > b.money;

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
GROUP BY p_id;

-- 正题
-- 1
SELECT s.*, a.score as score_01, b.score as score_02
FROM student s,
     (SELECT sid, score FROM sc WHERE cid=01) a,
     (SELECT sid, score FROM sc WHERE cid=02) b
WHERE a.sid = b.sid AND a.score > b.score AND s.sid = a.sid;

-- 2
SELECT sid, sname, avg(score) as avg_score
FROM student as s, sc
WHERE s.sid = sc.sid
GROUP BY s.sid
HAVING avg_score > 60;

-- 3
SELECT s.* 
FROM student s
WHERE sid in (SELECT sid FROM sc WHERE score IS NOT NULL);

-- 4
SELECT s.sid as '学号', s.sname as '学生名', COUNT(cid) as '选课总数', sum(score) as '总成绩'
FROM student as s LEFT JOIN sc
ON s.sid = sc.sid
GROUP BY s.sid;

-- 4.1
select s.sid, s.sname, count(*) as 选课总数, sum(score) as 总成绩,
    sum(case when cid = 01 then score else null end) as score_01,
    sum(case when cid = 02 then score else null end) as score_02,
    sum(case when cid = 03 then score else null end) as score_03
from student as s, sc
where s.sid = sc.sid
group by s.sid;

-- 5
SELECT COUNT(id) as t_num FROM teacher 
WHERE tname like '李%';

-- 6
SELECT s.*
FROM student s
		 INNER JOIN
		 sc on s.sid = sc.sid
		 INNER JOIN
		 course c on sc.cid = c.cid
		 INNER JOIN
		 teacher t on c.tid = t.tid
WHERE t.tname='张三';

-- 7
select * from student where sid in (select sid from sc group by sid having count(cid) < 3);

-- 9
SELECT s.*
FROM student s
WHERE s.sid in (
    select sid from sc
    where cid in (select cid from sc where sid = '01') and sid <>'01'
    group by sid
    having COUNT(cid)>=3				
	);

-- 8
select * from student where sid in(
    select distinct sid from sc where cid in(
        select cid from sc where sid='01'
    ) and sid <> '01'
);

-- 10
SELECT sname FROM student
WHERE sid not in (
	SELECT sc.sid 
	FROM sc
			 INNER JOIN
			 course c on sc.cid = c.cid
			 INNER JOIN
			 teacher t on c.tid = t.tid
	 WHERE t.tname = '张三'
);

-- 11
select s.sid, s.sname, avg(score)
from student as s, sc
where s.sid = sc.sid and score<60
group by s.sid
having count(score)>=2;

-- 12
select s.*, sc.score
from student as s, sc
where s.sid = sc.sid and sc.score<60
ORDER BY sc.score desc;

-- 13
select sid,
    sum(case when cid=01 then score else null end) as score_01,
    sum(case when cid=02 then score else null end) as score_02,
    sum(case when cid=03 then score else null end) as score_03
from sc group by sid
order by avg(score) desc;

-- 14
select c.cid as 课程号, c.cname as 课程名称, count(*) as 选修人数,
    max(score) as 最高分, min(score) as 最低分, avg(score) as 平均分,
    sum(case when score >= 60 then 1 else 0 end)/count(*) as 及格率,
    sum(case when score >= 70 and score < 80 then 1 else 0 end)/count(*) as 中等率,
    sum(case when score >= 80 and score < 90 then 1 else 0 end)/count(*) as 优良率,
    sum(case when score >= 90 then 1 else 0 end)/count(*) as 优秀率
from sc, course c
where c.cid = sc.cid
group by c.cid
order by count(*) desc, c.cid asc;

-- 15-分数排名
select s.*, rank_01, rank_02, rank_03, rank_total
from student s
left join (select sid, rank() over(partition by cid order by score desc) as rank_01 from sc where cid=01) A on s.sid=A.sid
left join (select sid, rank() over(partition by cid order by score desc) as rank_02 from sc where cid=02) B on s.sid=B.sid
left join (select sid, rank() over(partition by cid order by score desc) as rank_03 from sc where cid=03) C on s.sid=C.sid
left join (select sid, rank() over(order by avg(score) desc) as rank_total from sc group by sid) D on s.sid=D.sid
order by rank_total asc;

-- 15.1
select s.*, rank_01, rank_02, rank_03, rank_total
from student s
left join (select sid, dense_rank() over(partition by cid order by score desc) as rank_01 from sc where cid=01) A on s.sid=A.sid
left join (select sid, dense_rank() over(partition by cid order by score desc) as rank_02 from sc where cid=02) B on s.sid=B.sid
left join (select sid, dense_rank() over(partition by cid order by score desc) as rank_03 from sc where cid=03) C on s.sid=C.sid
left join (select sid, dense_rank() over(order by avg(score) desc) as rank_total from sc group by sid) D on s.sid=D.sid
order by rank_total asc;

-- 17
select c.cid as 课程编号, c.cname as 课程名称, A.*
from course as c,
(select cid,
    sum(case when score >= 85 then 1 else 0 end)/count(*) as 100_85,
    sum(case when score >= 70 and score < 85 then 1 else 0 end)/count(*) as 85_70,
    sum(case when score >= 60 and score < 70 then 1 else 0 end)/count(*) as 70_60,
    sum(case when score < 60 then 1 else 0 end)/count(*) as 60_0
from sc group by cid) as A
where c.cid = A.cid;
