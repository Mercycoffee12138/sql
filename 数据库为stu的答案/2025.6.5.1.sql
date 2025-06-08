SELECT distinct stu_id,stu_name,student.col_id
FROM student
WHERE not EXISTS(
	SELECT 1
	from course
	WHERE credits>=3
	AND not EXISTS(
		SELECT 1
		FROM takes 
		WHERE takes.stu_id=student.stu_id
		AND takes.cor_id=course.cor_id
	)
)
#用连续的两个not eixsts表示全部的关系其实很简单，最外面的用来找到结果，第一个not exists里面的用来标定我们查找的数据范围，第二个not exists里面的表用来连接外面两个表

SELECT stu_id,stu_name
FROM student
WHERE not EXISTS(
	SELECT 1
	from 	course
	left join college on course.col_id=college.col_id
	WHERE col_name='计算机学院'
	AND not EXISTS(
		SELECT 1
		FROM takes 
		WHERE takes.stu_id=student.stu_id
		AND takes.cor_id=course.cor_id
	)
)

SELECT distinct student.stu_id,stu_name,col_name
FROM student
left join college on student.col_id=college.col_id
left join takes t1 on student.stu_id=t1.stu_id
WHERE t1.mid_score is not null AND t1.fin_score is not null and
not EXISTS(
	SELECT 1
	FROM takes 
	WHERE takes.stu_id=student.stu_id
	AND (mid_score<60 OR fin_score<60)
)