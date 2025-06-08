SELECT catid,catname
FROM category
WHERE num>1000
and catid<>'c2';

SELECT stuid,stuname
FROM student
WHERE degree='本科生'
ORDER BY stuid DESC
LIMIT 1 OFFSET 1;

SELECT stuid,stuname
FROM student
WHERE not EXISTS(
	SELECT 1
	FROM borrow
	WHERE student.stuid=borrow.stuid
);

SELECT sum(3*price) as 赔偿金额
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on book.bookid=borrow.bookid
WHERE stuname='周昕';

SELECT bookid,bookname,author,price
FROM book 
left join category on book.catid=category.catid
WHERE catname='经济'
ORDER BY price DESC;

SELECT bookid,bookname,author,price,catid
FROM book
WHERE bookname like '%学';

SELECT bookname,borrowdate
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
WHERE stuname='王玲'
ORDER BY borrowdate ASC;

SELECT book.bookid as 图书编号,bookname as 书名
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
left join category on book.catid=category.catid
WHERE stuname='王玲'
AND catname='计算机技术';

SELECT distinct student.stuid,stuname
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
left join category on book.catid=category.catid
WHERE catname='计算机技术'
AND student.stuid in (
	SELECT b1.stuid
	FROM borrow b1
	left join book  b2 on b1.bookid=b2.bookid
	left join category  c1 on b2.catid=c1.catid
	WHERE b1.borrowdate=borrow.borrowdate
	AND c1.catname=category.catname
	GROUP BY b1.stuid
	HAVING count(*)>1
);

SELECT student.stuid,stuname,sum(price) as totalprice
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
left join category on book.catid=category.catid
WHERE catname='计算机技术'
GROUP BY student.stuid
ORDER BY sum(price) DESC
limit 1 offset 1;

SELECT s.stuid, s.stuname, totals.totalprice
FROM student s
JOIN (
    SELECT br.stuid, SUM(b.price) AS totalprice
    FROM borrow br
    JOIN book b ON br.bookid = b.bookid  
    JOIN category c ON b.catid = c.catid
    WHERE c.catname = '计算机技术'
    GROUP BY br.stuid
) totals ON s.stuid = totals.stuid
WHERE (
	SELECT COUNT(DISTINCT t2.totalprice)
    FROM (
        SELECT br2.stuid, SUM(b2.price) AS totalprice
        FROM borrow br2
        JOIN book b2 ON br2.bookid = b2.bookid
        JOIN category c2 ON b2.catid = c2.catid  
        WHERE c2.catname = '计算机技术'
        GROUP BY br2.stuid
    ) t2
		WHERE totals.totalprice>t2.totalprice
)=1
ORDER BY s.stuid