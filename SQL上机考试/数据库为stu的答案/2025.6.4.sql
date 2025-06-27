SELECT distinct col_id
FROM student
WHERE col_id is not null;

SELECT col_id,count(*) as cor_count
FROM course
GROUP BY col_id;

SELECT col_id,avg(age) as avg_age
FROM student 
GROUP BY col_id
HAVING avg(age)>19
ORDER BY avg(age) DESC;

SELECT stu_id,stu_name
FROM student
WHERE stu_name like '%王安%'
or stu_id is null;

SELECT cor_name,avg(fin_score) as avg_fin_score
FROM takes
left join course on takes.cor_id=course.cor_id
left join college on course.col_id=college.col_id
WHERE col_name='计算机学院'
GROUP BY cor_name
ORDER BY avg(fin_score) DESC;

SELECT a.cor_name,b.cor_name
FROM course a,course b 
WHERE a.day=b.day 
AND a.cor_id>b.cor_id
AND ((a.start_time<=b.end_time AND a.start_time>=b.start_time)
or (a.end_time<=b.end_time AND a.start_time>=b.start_time));

SELECT course.cor_id,cor_name
FROM takes 
left join course on takes.cor_id=course.cor_id
GROUP BY cor_id
ORDER BY avg(mid_score*0.3+fin_score*0.7) DESC
LIMIT 3;

SELECT stu_name,col_name
FROM student
left join college on student.col_id=college.col_id
WHERE not EXISTS(
	SELECT 1
	FROM takes 
	WHERE student.stu_id=takes.stu_id
);

SELECT stu_id,stu_name
FROM student
WHERE EXISTS(
	SELECT 1
	FROM takes t1
	WHERE student.stu_id=t1.stu_id
	AND (t1.mid_score*0.3+t1.fin_score*0.7)>(
		SELECT avg(t2.mid_score*0.3+t2.fin_score*0.7)
		FROM takes t2 
		WHERE t1.cor_id=t2.cor_id 
		GROUP BY cor_id
	)
)AND(
	SELECT avg(t3.mid_score*0.3+t3.fin_score*0.7)
	FROM takes t3 
	WHERE student.stu_id=t3.stu_id
)>(
	SELECT avg(t4.mid_score*0.3+t4.fin_score*0.7)
	FROM takes t4 
	left join student s1 on t4.stu_id=s1.stu_id
	WHERE s1.col_id=student.col_id
);

SELECT distinct stu_name,cor_name
FROM student 
left join takes on student.stu_id=takes.stu_id
left join course on course.cor_id=takes.cor_id
WHERE student.stu_name in (
	SELECT s1.stu_name
	FROM student s1
	GROUP BY s1.stu_name 
	HAVING count(*)>1
)AND (
	SELECT count(*)
	FROM student s2 
	WHERE s2.stu_name=student.stu_name
	GROUP BY stu_name
)=(
	SELECT count(*)
	FROM takes t1
	left join student s3 on t1.stu_id=s3.stu_id 
	WHERE takes.cor_id=t1.cor_id
	AND student.stu_name=s3.stu_name
)