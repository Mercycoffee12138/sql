SELECT stu_id
FROM takes
WHERE mid_score>95 AND fin_score>95;

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
WHERE idcard like '12%' or idcard is null;

SELECT student.stu_id,student.stu_name,avg(fin_score) as avg_fin_score
FROM student
left join takes on student.stu_id=takes.stu_id
left join college on student.col_id=college.col_id
WHERE col_name='金融学院'
GROUP BY student.stu_id;

SELECT student.stu_id,student.stu_name
FROM student
WHERE student.stu_name in (
	SELECT s1.stu_name
	FROM student s1
	GROUP BY stu_name
	HAVING count(*)>1
);

SELECT student.stu_id,student.stu_name
FROM student
WHERE student.stu_id not IN(
	SELECT takes.stu_id
	FROM takes 
	left join course on takes.cor_id=course.cor_id
	WHERE course.credits=3.5
);

SELECT student.stu_id,student.stu_name
FROM student
WHERE student.stu_id in (
	SELECT t1.stu_id
	FROM takes t1 
	left join course  c1 on t1.cor_id=c1.cor_id
	left join college c2 on c1.col_id=c2.col_id 
	WHERE col_name='计算机学院'
	GROUP BY stu_id
	HAVING count(*)=(
		SELECT count(*)
		FROM course c3 
		left join college c4 on c3.col_id=c4.col_id
		WHERE col_name='计算机学院'
	)
);

SELECT college.col_id,college.col_name
FROM college 
left join student on college.col_id=student.col_id
GROUP BY college.col_id
HAVING count(*)<3 or count(*) is null;

SELECT course.cor_id,course.cor_name,student.stu_id,student.stu_name,(mid_score*0.3+fin_score*0.7) as final_score
FROM course
left join takes t1 on course.cor_id=t1.cor_id
left join student on student.stu_id=t1.stu_id
WHERE (mid_score*0.3+fin_score*0.7)=(
	SELECT MAX(mid_score*0.3+fin_score*0.7)
	FROM takes t2
	WHERE t1.cor_id=t2.cor_id
)
ORDER BY (mid_score*0.3+fin_score*0.7) DESC;