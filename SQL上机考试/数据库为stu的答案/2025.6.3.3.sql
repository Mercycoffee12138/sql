SELECT student.stu_id,stu_name
FROM student 
WHERE (
	SELECT count(*)
	FROM takes
	WHERE takes.stu_id=student.stu_id
	AND (
		SELECT count(*)
		FROM takes t1 
		WHERE takes.cor_id=t1.cor_id
		and takes.fin_score<t1.fin_score
	)=1
);

SELECT s.stu_id, s.stu_name, c.cor_name, t.fin_score
FROM student s
JOIN takes t ON s.stu_id = t.stu_id  
JOIN course c ON t.cor_id = c.cor_id
WHERE t.fin_score IS NOT NULL
AND (
    SELECT COUNT(*)
    FROM takes t1 
    WHERE t1.cor_id = t.cor_id
    AND t1.fin_score IS NOT NULL
    AND t1.fin_score > t.fin_score
) = 1
ORDER BY c.cor_name, t.fin_score DESC;