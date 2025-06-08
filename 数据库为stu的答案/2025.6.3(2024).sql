SELECT stu_id
FROM takes 
WHERE mid_score>95 
AND fin_score>95;

SELECT cor_id,avg(mid_score*0.3+fin_score*0.7) as avg_score
FROM takes
GROUP BY cor_id;

SELECT cor_id,count(*) as cor_select_num
FROM takes
GROUP BY cor_id
HAVING count(*)>=10
ORDER BY count(*) DESC;

SELECT stu_id
FROM student
WHERE idcard like '12%'
or 	idcard is null;

SELECT student.stu_id,stu_name,avg(fin_score) as avg_fin_score
FROM student
left join takes on student.stu_id=takes.stu_id
left join college on student.col_id=college.col_id
WHERE col_name='金融学院'
GROUP BY student.stu_id;

SELECT stu_id,stu_name
FROM student 
WHERE stu_name in(
SELECT s1.stu_name
FROM student s1
GROUP BY s1.stu_name
HAVING count(*)>1)

SELECT stu_id,stu_name
FROM student
WHERE not EXISTS(
	SELECT 1
	FROM takes
	left join course on takes.cor_id=course.cor_id
	WHERE takes.stu_id=student.stu_id AND credits=3.5
);

SELECT stu_id,stu_name
FROM student
WHERE not EXISTS (
	SELECT 1
	FROM course
	left join college on course.col_id=college.col_id
	WHERE col_name='计算机学院'
	AND not EXISTS(
		SELECT 1
		FROM takes
		WHERE takes.stu_id=student.stu_id
		AND course.cor_id=takes.cor_id
	)
);

SELECT college.col_id,col_name
FROM college
left join student on college.col_id=student.col_id
GROUP BY college.col_id
HAVING count(*)<3 or count(*) is null;

SELECT course.cor_id,cor_name,student.stu_id,stu_name,(takes.mid_score*0.3+takes.fin_score*0.7) as final_score
FROM course 
left join takes on course.cor_id=takes.cor_id
left join student on student.stu_id=takes.stu_id
WHERE (takes.mid_score*0.3+takes.fin_score*0.7) in (
	SELECT max(t1.mid_score*0.3+t1.fin_score*0.7)
	FROM takes t1 
	WHERE course.cor_id=t1.cor_id
)
ORDER BY (takes.mid_score*0.3+takes.fin_score*0.7) DESC;
