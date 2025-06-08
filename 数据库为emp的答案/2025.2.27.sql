 SELECT empid,empname,age,depid
 FROM employee
 WHERE empname like '张%' AND age>30
 ORDER BY empid ;
 
 SELECT proid,projectname,budget,catname
 FROM project left join category on project.catid=category.catid
 WHERE budget>50000;
 
 SELECT empname,count(*) as pronum,avg(budget) as meanbudget
 FROM workson 
 left join employee on workson.empid=employee.empid
 left join project on workson.proid=project.proid
 GROUP BY employee.empid;
 
 SELECT employee.depid,depname,count(*) as empNum
 FROM employee 
 left join department on employee.depid=department.depid
 WHERE location='天津'
 GROUP BY depid;
 
 SELECT employee.empid,empname,age,sex,employee.depid
 FROM employee
 left join workson on employee.empid=workson.empid
 left join project on workson.proid=project.proid
 left join category on project.catid=category.catid
where catname='软件类' AND age>35;

SELECT category.catid,count(workson.job) as jobNum
FROM category
left join project on category.catid=project.catid
left join workson on project.proid=workson.proid
WHERE workson.empid='10102'
GROUP BY category.catid;

SELECT projectname,min(age) as youngest,max(age) as oldest
FROM project
left join workson on project.proid=workson.proid
left join employee on employee.empid=workson.empid
GROUP BY projectname;

SELECT empid,empname,age
FROM employee
left join department on employee.depid=department.depid
WHERE depname='开发部'
AND sex='男'
ORDER BY age DESC
LIMIT 1;

SELECT project.proid,projectname,budget,count(*) as empNum
FROM workson 
left join project on workson.proid=project.proid
GROUP BY project.proid
HAVING count(*)<=3;

SELECT empid,empname,age,sex,depid
FROM employee
WHERE age>30
AND not  exists(
	SELECT 1
	FROM workson
	left join project on workson.proid=project.proid
	where employee.empid=workson.empid
	AND budget>160000
);
