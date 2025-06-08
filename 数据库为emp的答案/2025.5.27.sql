SELECT empid,empname,age,depid
FROM employee
where empname like '王%'
ORDER BY age ;

SELECT empid,empname,age,location
FROM employee
left join department on employee.depid=department.depid
WHERE sex='男';

SELECT proid,projectname,budget
FROM project
left join category on project.catid=category.catid
where category.catid='c2'
ORDER BY budget
LIMIT 1;

SELECT department.depid,depname,location,count(*) as empCount
FROM department
left join employee on department.depid=employee.depid
GROUP BY depid
HAVING count(*)<5;

SELECT empid,empname,age,sex,depid
FROM employee
WHERE sex='男'
AND not exists(
	SELECT 1
	FROM workson
	left join project on workson.proid=project.proid
	left join category on project.catid=category.catid
	WHERE workson.empid=employee.empid
	AND catname='设计类'
);

SELECT employee.empid,empname,count(*) as procnt
FROM employee
left join department on employee.depid=department.depid
left join workson on employee.empid=workson.empid
WHERE location='北京'
AND EXISTS(
	SELECT 1
	FROM workson
	left join project on workson.proid=project.proid
	WHERE workson.empid=employee.empid
	AND projectname='产品推广'
)
GROUP BY employee.empid;

