SET @nm := 0,
 -- 当num改变 值改变为实际排名 否则不变
@rn := 1,
 -- 实际排名
@arn := 1;

SELECT
  user_group_id,

IF (@nm = num, @rn, @rn := @arn) 相同成绩下并列,
 @nm := num 数值,
 @arn :=@arn + 1 顺序排名
FROM
  (
    SELECT
      user_group_id,
      count(1) num
    FROM
      loan_approve_project a
    GROUP BY
      user_group_id
    ORDER BY
      count(1) ASC
  ) a
