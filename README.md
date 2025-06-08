### 这里是南开大学2025spring的sql考试总结：
#### 对于之前的连用两个not exists连用的一些思考：例题：选择全部A表a属性的B表的信息。
套用公式如下：

```sql
select B.b1,B.b2....
from B
where not exists(
  select  1
  from A
  where not exists(
    select   1
    from C(这里的C表是连接A,B两个表的表，A,B两个表是没有交集的两个表)
    where C.bc=B.bc
    and C.ac=A.ac
  )
);
```

让我们来举一个具体的例子：
2024年中选修了所有计算机学院的课的学生学号和学生姓名：

```sql
select stu_id,stu_name
from  student
where  not exists(
  select 1
  from course
  left join college on course.col_id=college.col_id
  where col_name='计算机学院'  
  and not exists(
    select 1
    from takes 
    where  takes.stu_id=student.stu_id
    and  takes.cor_id=course.cor_id
  )
);
```

 遇到这种题目直接套公式就行。

#### 这里是sql考试的一些小提醒：我在练习的时候一直没有搞懂所以总是会出现语法错误，这里提醒一些细节：
##### (1)首先是where语句中不可以用聚合函数(救命虽然很弱智然是我刚开始确实经常犯错误)。
##### (2)然后就是GROUP BY用了之后要检查你的select里面有没有GROUP BY不能处理的变量，不然也会报错。
##### (3)考试中的连接最好用left join A on ...，因为有时候空值的情况真的很难排出来，容易犯错误。
##### (4)老师给的参考答案一般都逻辑不是很通畅，我建议的逻辑是：select (所有需要查询的变量) from (这些变量来自的表全部用left join 直接接起来，注意不要多select后面有什么接什么不然逻辑容易混)  然后再where。
##### (5)对于考试中的条件直接翻译，给的参考答案就喜欢弯弯绕绕的(非常的难懂而且不好理解)
##### (6)2023级对于sql考试增加了难度(难度可以参考模拟题，当然2024级考试的时候也会给2025年的真题)，考试时间也从60分钟变为了80分钟，建议好好练习并整理出一套自己的心得。(这考试我手指不停敲还用了navicat的自动补全也写了50分钟才写完)。
