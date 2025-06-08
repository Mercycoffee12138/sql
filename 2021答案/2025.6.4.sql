SELECT catid,sum(price) as totalprice
FROM book
GROUP BY catid;

SELECT bookname,author,price,(SELECT round(avg(price),1)  FROM book) as  avgprice 
FROM book
WHERE price>(SELECT round(avg(price),1)  FROM book)
ORDER BY price DESC;

SELECT degree,count(distinct majorid) as num
FROM student
GROUP BY degree;

SELECT bookid,bookname,author,price
FROM book
left join category on category.catid=book.catid
WHERE 	catname='政治'
ORDER BY price DESC;

SELECT stuid,stuname
FROM student
left join major on student.majorid=major.majorid
WHERE department='计算机与控制工程学院';

SELECT book.bookid,bookname,author
FROM book
left join borrow on book.bookid=borrow.bookid
WHERE catid='c1'
AND borrowdate=(
	SELECT max(b1.borrowdate)
	FROM borrow b1
	left join book b2 on b1.bookid=b2.bookid
	WHERE b2.catid='c1'
);

SELECT book.bookid,bookname,author
FROM borrow
left join book on borrow.bookid=book.bookid
WHERE stuid='200810111';

SELECT stuname,max(price) as highestprice,min(price) as lowestprice
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
WHERE stuname like '王%'
GROUP BY student.stuid;

SELECT distinct student.stuid,stuname,degree,majorid
FROM student
left join borrow on student.stuid=borrow.stuid
left join book on borrow.bookid=book.bookid
left join category on book.catid=category.catid
WHERE catname='计算机技术';

SELECT stuid,stuname
FROM student
WHERE not EXISTS(
	SELECT catid
	FROM category
	WHERE not EXISTS(
		SELECT 1
		FROM borrow
		left join book on borrow.bookid=book.bookid
		WHERE student.stuid=borrow.stuid
		AND book.catid=category.catid
	)
)