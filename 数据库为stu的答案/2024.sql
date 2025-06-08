SELECT DISTINCT student.stu_id,student.stu_name
FROM student
left join takes on student.stu_id=takes.stu_id
WHERE student.stu_id not in (
	SELECT t.stu_id
	FROM course c join takes t on c.cor_id=t.cor_id 
	WHERE c.credits=3.5
)