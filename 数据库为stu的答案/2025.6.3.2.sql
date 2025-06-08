SELECT distinct col_id
FROM course
WHERE col_id is not null;

SELECT stu_id,count(*) as course_count
FROM takes 
GROUP BY stu_id
ORDER BY count(*) DESC;

SELECT college.col_id,avg(credits) as avg_credits
FROM course
left join college on course.col_id=college.col_id
GROUP BY col_id
ORDER BY avg(credits) DESC;

SELECT stu_id,stu_name,age
FROM student
WHERE stu_name like '王%'
or age is null;

SELECT cor_name,avg(mid_score)
FROM takes 
left join course on takes.cor_id=course.cor_id
left join college on course.col_id=college.col_id
WHERE col_name='网络空间安全学院'
GROUP BY	course.cor_id;

SELECT stu_id,stu_name
FROM student
WHERE not EXISTS(
	SELECT 1
	FROM course
	WHERE course.credits=3.5
	AND not EXISTS(
		SELECT 1 
		FROM takes
		WHERE takes.stu_id=student.stu_id
		AND course.cor_id=takes.cor_id 
	)
)