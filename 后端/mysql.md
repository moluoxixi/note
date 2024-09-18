# 主要内容

```
sql基本增删改查
子查询
索引(约束)
视图

//以下未学
存储与存储过程
触发器
事务
```

# cmd命令

| 命令                             | 说明                                                          |
| ------------------------------ | ----------------------------------------------------------- |
| net start/stop MySQL服务名        | 启动/停止sql服务(分别是mysql80和mysql67),也可以开始搜索框搜索运行services.msc手动停止 |
| mysql -h 主机名 -P 端口号 -u用户名 -p密码 | 连接mysql,不写主机名和端口号分别默认为localhost和3306                        |


# 规范

关键字，变量/函数名大写(全大写不是大驼峰)，其余小写

字符串和时间用单引号，[列的别名](#一般select语句)用双引号

dual代表临时表

# 常见函数
| 函数                  | 用法                                | 示例(value是一个列的名字)                                          |
| ------------------- | --------------------------------- | --------------------------------------------------------- |
| ABS(x)              | 返回x的绝对值                           | SELECT  ABS(value) AS av FROM ExampleTable;               |
| CEIL(x)/CEILING(x)  | 返回大于或等于某个值的最小整数                   | SELECT CEIL(value) AS cv FROM ExampleTable;               |
| FLOOR(x)            | 返回小于或等于某个值的最大整数                   | SELECT FLOOR(value) AS fv FROM ExampleTable;              |
| LEAST(e1,e2,e3…)    | 返回列表中的最小值                         | SELECT LEAST(value, other_value) AS lv FROM ExampleTable; |
| GREATEST(e1,e2,e3…) | 返回列表中的最大值                         | SELECT LEAST(value, other_value) AS lv FROM ExampleTable; |
| MOD(x,y)            | 返回X除以Y后的余数                        | SELECT MOD(value, 3) AS mv FROM ExampleTable;             |
| ROUND(x)            | 返回一个对x的值进行四舍五入后，最接近于X的整数          |                                                           |
| ROUND(x,y)          | 返回一个对x的值进行四舍五入后最接近X的值，并保留到小数点后面Y位 | SELECT ROUND(value, 1) AS rv FROM ExampleTable;           |
| TRUNCATE(x,y)       | 保留x的小数位后y位                        | SELECT TRUNCATE(value, 1) AS tv FROM ExampleTable;        |

# 运算符
| 运算符               | 运算符语法                                                                 | 说明                                                                    |     |
| ----------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------- | --- |
| AND               |                                                                       | 与                                                                     |     |
| OR                |                                                                       | 或                                                                     |     |
| NOT               |                                                                       | 非                                                                     |     |
| IS NULL 或者 ISNULL | SELECT 列 FROM 表 WHERE 列 IS NULL<br/>SELECT 列 FROM 表 WHERE 列 ISNULL(列) | 为NULL则返回1，否则返回0                                                       |     |
| IS NOT NULL       | SELECT 列 FROM 表 WHERE 列 IS NOT NULL                                   | 不为NULL则返回1，否则返回0                                                      |     |
| 最小值LEAST          | SELECT LEAST(price1, price2, ...) `min_price` FROM products;          | 取这些列中的最小值                                                             |     |
| 最大值GREATEST       | SELECT GREATEST(price1, price2, ...) `max_price` FROM products;       | 取这些列中的最大值                                                             |     |
| 范围值BETWEEN AND    | SELECT D FROM TABLE WHERE C BETWEEN A AND B                           | 当C大于或等于A，并且C小于或等于B时，结果为1，否则结果为0                                       |     |
| 是否存在IN            | SELECT 列 FROM 表 WHERE 列 IN ('a','b')                                  | 断给定的值是否是IN列表中的一个值                                                     |     |
| 是否不存在NOT IN       | SELECT 列 FROM 表 WHERE 列 NOT IN ('a','b')                              | 断给定的值是否不是IN列表中的一个值                                                    |     |
| 模糊查询LIKE          | `SELECT job_id FROM jobs WHERE job_id LIKE ‘IT%‘`                     | “%”：匹配0个或多个字符。<br/>“_”：只能匹配一个字符。<br/>如果需要模糊查询`IT%`开头的字符需要进行转义,即`IT\%` |     |
| 指定转义符ESCAPE       | `SELECT job_id FROM jobs >WHERE job_id LIKE ‘IT$_%‘ escape ‘$‘`       | 使$作为转义字符,即$等同于\|                                                      |     |
| 正则运算符REGEXP       | `SELECT job_id  FROM jobs WHERE job_id REGEXP 'IT.*'`                 | 返回所有                                                                  |     |


# 聚合函数

| 函数        | 用法                      | 示例(value是一个列的名字)                     |
| --------- | ----------------------- | ------------------------------------ |
| SUM(列名)   | 聚合函数,只返回一条数据,结果是这一列的总和  | SELECT SUM(amount) AS sm FROM sales; |
| AVG(列名)   | 聚合函数,只返回一条数据,结果是这一列的平均值 | SELECT AVG(amount) AS av FROM sales; |
| MAX(列名)   | 聚合函数,只返回一条数据,结果是这一列的最大值 | SELECT MAX(amount) AS mx FROM sales; |
| MIN(列名)   | 聚合函数,只返回一条数据,结果是这一列的最小值 | SELECT MIN(amount) AS mn FROM sales; |
| COUNT(列名) | 聚合函数,只返回一条数据,结果是这一列的总行数 | SELECT COUNT(*) AS ct FROM sales;    |


# 聚合函数操作符

## GROUP BY

GROUP BY 按指定列进行分组再计算聚合结果

```sql
​
//分组后求和
//假设Orders长这样
//OrderID | CustomerName | OrderAmount  
//--------|--------------|------------  
//1       | Alice        | 100  
//2       | Bob          | 150  
//3       | Alice        | 200  
//4       | Carol        | 120
​
SELECT CustomerName, SUM(OrderAmount) AS TotalAmount
FROM Orders  
GROUP BY CustomerName;
​
//返回
CustomerName | TotalAmount  
-------------|------------  
Alice        | 300  
Bob          | 150  
Carol        | 120
```

## WITH ROLLUP

与ORDER BY相斥,用于在 `GROUP BY` 查询的结果集中添加一个或多个超级汇总行(每一个分组添加一行,并在最后添加总和)

```sql
//查询会返回每个年份和每个国家的总利润，同时还会添加额外的汇总行。这些汇总行会显示不同层次的汇总数据：
​
//对于每个年份，会有一个包含 NULL(Country列) 作为国家值的行，显示该年份所有国家的总利润。
//在结果集的末尾，会有一个包含两个 NULL 值(Year和Country列值为NULL)的行，显示所有年份和所有国家的总利润。
SELECT Year, Country, SUM(Profit) as TotalProfit  
FROM Sales  
GROUP BY Year, Country WITH ROLLUP;
//结果,显而易见,表是不含NULL的那几行组成的,就不展示了
Year | Quarter | TotalProfit  
-----|---------|------------  
2020 | Q1      | 10000  
2020 | Q2      | 12000  
2020 | NULL    | 22000      -- 2020年的总利润  
2021 | Q1      | 11000  
2021 | Q2      | 13000  
2021 | NULL    | 24000      -- 2021年的总利润  
NULL | NULL    | 46000      -- 所有年份和季度的总利润
```

## HAVING

**与WHERE并不互斥,可以同时使用**

需要与GROUP BY一起使用,用于筛选最后的结果集

| 关键字    | 优点                 | 缺点                  |
| ------ | ------------------ | ------------------- |
| WHERE  | 先筛选表的数据再进行分组，执行效率高 | 不能使用分组中的计算函数进行筛选    |
| HAVING | 可以使用分组中的计算函数       | 在最后的结果集中进行筛选，执行效率较低 |


## 正则运算符REGEXP

## 正则运算符REGEXP

REGEXP运算符用来匹配字符串，语法格式为： expr REGEXP 匹配条件 。

> （1）`^`匹配以该字符后面的字符开头的字符串。 
> （2）`$`匹配以该字符前面的字符结尾的字符串。 
> （3）`.`匹配任何一个单字符。 
> （4）`[...]`匹配在方括号内的任何字符。例如，`[abc]`匹配`a`或`b`或`c`。为了命名字符的范围，使用一 个`-`。`[a-z]`匹配任何字母，而`[0-9]`匹配任何数字。
> （5）`*`匹配零个或多个在它前面的字符。例如，`x*`匹配任何数量的`x`字符，`[0-9]*`匹配任何数量的数字， 而`*`匹配任何数量的任何字符。


# 流程控制语句

```java
//IF和IFNULL
//从左到右一直找到不是NULL的值,IFNULL相反
SELECT IF(列名1,列名2,...) "别名" FROM 表名;
//eg: 查询a列,如果是空值返回默认值'你好'
SELECT IF(a,'你好') "别名" FROM 表名;
​
​
​
//CASE WHEN THEN ELSE END
​
//等于while语句
CASE expression  
    WHEN value1 THEN result1  
    WHEN value2 THEN result2  
    ...  
    ELSE result  
END
​
//等于case
SELECT   
    name,   
    salary,  
    CASE   
        WHEN salary < 3000 THEN 'Low'  
        WHEN salary BETWEEN 3000 AND 7000 THEN 'Medium'  
        WHEN salary > 7000 THEN 'High'  
        ELSE 'Unknown'  
    END AS salary_level  
FROM employees;
```

# 排序与分页

## 排序

```java
//使用ORDER BY子句排序,需要放在语句结尾, ASC（ascend）升序 , DESC（descend）降序
​
//ORDER BY子句首先根据last_name列的值进行升序排序。对于具有相同last_name值的行，它们将根据salary列的值进行降序排序
SELECT last_name, salary
FROM employees
ORDER BY last_name ASC, salary DESC;
```

## 分页

```java
//使用LIMIT和OFFSET进行分页
//从第十条开始取,取10个
SELECT * FROM 表名 LIMIT 10 OFFSET 10;
//与第一句等同
SELECT * FROM 表名 LIMIT 10,10;
```

# sql命令分类

## DDL数据定义语言

```java
//create创建 alter修改 drop删除 rename重命令 truncate清空
```

### create创建(use&show这两不是DDL)

```java
CREATE DATABASE 数据库名;                       //创建数据库
CREATE DATABASE 数据库名 CHARACTER SET 字符集;   //创建数据库并指定字符集
CREATE DATABASE IF NOT EXISTS 数据库名;         //判断数据库是否已经存在，不存在则创建数据库（ 推荐）
​
USE 数据库名;                                   //使用或切换到某个数据库
​
create table 表名(字段 数据类型 [约束],..)              //创建表
​
show tables form 数据库名查看某个数据库的所有表
show create table/database/databases 名称显示表/数据库/所有数据库的详细信息
```

### drop删除

```java
drop table/database 名称删除表/数据库
DROP DATABASE IF EXISTS 数据库名; //判断数据库是否已经存在，不存在则删除数据库（ 推荐）
```

### alter修改(列的增删改)

```java
//追加一个列
ALTER TABLE 表名 ADD 列名 数据类型;
//修改一个列的类型和约束
ALTER TABLE 表名 MODIFY 列名 列的类型 default 默认值;
//重命名列
ALTER TABLE 表名 CHANGE  列名 新列名 新数据类型;
//删除列
ALTER TABLE 表名 DROP 列名

```

### truncate清空

```java
TRUNCATE TABLE 表名; //清空表

```

## DML数据操作语言

```java
//inset插入 delete删除 update更新 select查询

```

### inset插入

```java
insert into 表名 values(value1,...);		 	  //为某个表添加一条记录(按列的顺序依次写值)
insert into 表名(列名,..) values(value1,..);	//为某个表添加一条记录,仅为指定列赋值

INSERT INTO 表名 VALUES(value1,...),……;			//为某个表添加多条记录,同理,可以添加多条并仅赋值指定列

//将查询结果插入指定表的指定列
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

```

### DELETE

```java
DELETE FROM 表名 [WHERE表达式];
//eg
DELETE FROM employees WHERE id=7;

```

### UPDATE

```java
UPDATE 表名 SET 列名=值,... [WHERE表达式];
//eg
UPDATE employees
SET department_id = 70
WHERE employee_id = 113;

```

### select查询

#### 一般select语句

```java
//在sql中select更像返回语句，返回表中指定列处理后组成的数据，返回结果叫结果集
//select 具体操作 from 表名 where 条件
	//常见操作有
		//指定列					 select 列名
		//指定列并赋值给别名			 select 列名 列的别名
		//指定列进行操作后赋值给别名   select 列名*12 列的别名
			//列的操作有操作符和流程控制函数

// 去除空值IFNULL(值1,值2) 当值1为null时,取值2

```

#### 多表查询(自连接与内外连接)与结果聚合

内连接:仅返回两个表中都满足条件的部分

外连接:会返回除内连接之外的其他表内容

```java
//多表查询 查询多个表中都存在的列
SELECT 列1,... FROM 表1 别名
连接符 表2 别名 ON 条件
连接符 表3 别名 ON 条件
...

//多表查询 查询多个表中指定表的列
SELECT 表的别名.名,... FROM 表1 别名
连接符 表2 别名 ON 条件
连接符 表3 别名 ON 条件
...

//INNER JOIN内连接,结果集仅返回交集
//eg JOIN是INNER JOIN的简写,SQL92中,在仅使用WHERE做条件时,可以省略JOIN
//很不推荐这种写法,这是隐式内连接,自己找相同的列进行连接
SELECT a, b 
FROM A,B
WHERE A.a1 = B.b2;

SELECT A.a, B.b 
FROM A JOIN B
ON A.a1 = B.b2;

//结果聚合
查询语句A UNION 查询语句B
//如果需要合并查询结果,使用UNION或者UNION ALL,区别是UNION ALL不会去除重复数据,UNION会去除重复数据
//结果集聚合,合并status为'shipped'和'pending'的结果,并去重
SELECT order_id, order_date, status FROM orders WHERE status = 'shipped'
UNION
SELECT order_id, order_date, status FROM orders WHERE status = 'pending';

```

![](images/WEBRESOURCE3f1f84922b37aa788fe33a0531642248image-20220531224319139.png)

#### 子查询

#### SELECT 语句的执行顺序

```java
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT 的字段 -> DISTINCT -> ORDER BY -> LIMIT
```

#### SQL的执行原理

SELECT 是先执行 FROM 这一步的。在这个阶段，如果是多张表联查，还会经历下面的几个步骤：

1. 首先先通过 CROSS JOIN 求笛卡尔积，相当于得到虚拟表 vt（virtual table）1-1；
2. 通过 ON 进行筛选，在虚拟表 vt1-1 的基础上进行筛选，得到虚拟表 vt1-2；
3. 添加外部行。如果我们使用的是左连接、右链接或者全连接，就会涉及到外部行，也就是在虚拟 表 vt1-2 的基础上增加外部行，得到虚拟表 vt1-3。

- 当然如果我们操作的是两张以上的表，还会重复上面的步骤，直到所有表都被处理完为止。这个过程得 到是我们的原始数据。
- 然后进入第三步和第四步，也就是 GROUP 和 HAVING 阶段 。在这个阶段中，实际上是在虚拟表 vt2 的 基础上进行分组和分组过滤，得到中间的虚拟表 vt3 和 vt4 。
- 当我们完成了条件筛选部分之后，就可以筛选表中提取的字段，也就是进入到 SELECT 和 DISTINCT 阶段 。
- 首先在 SELECT 阶段会提取想要的字段，然后在 DISTINCT 阶段过滤掉重复的行，分别得到中间的虚拟表 vt5-1 和 vt5-2 。
- 当我们提取了想要的字段数据之后，就可以按照指定的字段进行排序，也就是 ORDER BY 阶段 ，得到 虚拟表 vt6 。
- 最后在 vt6 的基础上，取出指定行的记录，也就是 LIMIT 阶段 ，得到最终的结果，对应的是虚拟表 vt7 。
- 当然我们在写 SELECT 语句的时候，不一定存在所有的关键字，相应的阶段就会省略。

## DCL数据控制语言

```java
//commit(提交) rollback(回滚) savapoint(暂存) grant(授权) revoke(回收权限)

```

# 约束,视图,存储

## 约束

1. 表级约束 包含多列约束,在创建语句的最后单独定义
2. 单列约束 约束跟在列定义后面

分类:

1. NOT NULL 非空约束，规定某个字段不能为空 
2. UNIQUE 唯一约束，规定某个字段在整个表中是唯一的 
3. PRIMARY KEY 主键(非空且唯一)约束 
4. FOREIGN KEY 外键约束 
5. CHECK 检查约束
6. DEFAULT 默认值约束

```mysql
#[]代表可选
CREATE TABLE 表名称(
    #非空约束
	列名 数据类型 NOT NULL, 						#规定这一列的值不能为空
    
    #唯一约束
	列名 数据类型 UNIQUE KEY,	  					#规定这一列在表中是唯一的
	[CONSTRAINT 约束名] UNIQUE KEY(列名1,...),	#表级写法,用于规定多列的值都是唯一的
    
    #主键约束
    列名 数据类型 PRIMARY KEY, 				   #唯一且非空(一个表只能有一个,且值不能为空)
    [CONSTRAINT 约束名] PRIMARY KEY(列名1,...),  #表级模式(如果是多列,多列作为复合主键)
    
    #自增约束,这里拿主键作为示例,可以换成唯一键列
    #8之后,将自增主键的计数器持久化到 重做日志 中,8之前重启会重置计数
    列名 数据类型 PRIMARY KEY AUTO_INCREMENT,   #初始值是1,自增长,唯一且非空,需要是键列(主键/唯一键),必须是整型
    
    #外键约束 从表（子表）：引用别人的表,主表（父表）：被引用的表
    [CONSTRAINT 约束名] FOREIGN KEY（从表的列名) REFERENCES 主表名(主表中被参考的列名)
    
    #默认约束
    列名 数据类型 DEFAULT 默认值,
    
    #检查约束,8之前写了无效,8之后有用
    列名 数据类型 CHECK(条件),					#限制值的范围,满足条件才会被插入表中
);

#查看都有哪些约束,information_schema是一个系统数据库,table_constraints是库中的约束表
SELECT * FROM information_schema.table_constraints WHERE table_name = '表名';
#清空表中指定列的约束
ALTER TABLE 表名称 MODIFY 列名 数据类型;
#修改表中指定列的约束
ALTER TABLE 表名称 MODIFY 列名 数据类型 UNIQUE KEY NOT NULL DEFAULT 默认值;

```

## 视图

通常不对表进行操作

视图是一种虚拟表,是对源表的映射,本身不具有数据,对视图的操作,就是对源表的操作,

视图赖以建立的表叫基表

### 创建视图

```mysql
#注意:
#1.查询语句可以查询视图,也可以查询多个表,也就是说,可以基于视图创建视图
#2.查询语句中不能存在子查询
CREATE VIEW 视图名称 AS 查询语句;
CREATE VIEW 视图名称(查询语句中每一列在视图表中取的新别名,...) AS 查询语句;

#eg 基于单个表创建视图
CREATE VIEW empvu80 AS
SELECT employee_id, last_name, salary FROM employees WHERE department_id = 80;

#eg 基于多个表创建视图
#查询多个表中相同列
CREATE VIEW empvu80 AS
SELECT employee_id, last_name, salary FROM employees,salarys WHERE department_id = 80;
#查询不同列
CREATE VIEW dept_sum_vu(name, minsal, maxsal, avgsal)
AS
SELECT d.department_name, MIN(e.salary), MAX(e.salary),AVG(e.salary)
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name;

#eg 基于视图创建视图 emp_dept是一个视图,这里通过内连接的方式连接它
CREATE VIEW emp_dept_ysalary
AS
SELECT emp_dept.ename,dname,year_salary
FROM emp_dept INNER JOIN emp_year_salary
ON emp_dept.ename = emp_year_salary.ename;

```

### 更新视图的数据

#### 一般情况

MySQL支持使用INSERT、UPDATE和DELETE语句对视图中的数据进行插入、更新和删除操作。当视图中的 数据发生变化时，数据表中的数据也会发生变化，反之亦然。

举例：UPDATE操作

```mysql
UPDATE emp_tel SET tel = '13789091234' WHERE ename = '孙洪亮';

```

举例：DELETE操作

```mysql
 DELETE FROM emp_tel WHERE ename = '孙洪亮';

```

#### 不可更新的视图

要使视图可更新，视图中的行和底层基本表中的行之间必须存在 一对一 的关系。另外当视图定义出现如下情况时，视图不支持更新操作：

- 在定义视图的时候指定了“ALGORITHM = TEMPTABLE”，视图将不支持INSERT和DELETE操作； 
- 视图中不包含基表中所有被定义为非空又未指定默认值的列，视图将不支持INSERT操作； 
- 在定义视图的SELECT语句中使用了 JOIN联合查询 ，视图将不支持INSERT和DELETE操作； 
- 在定义视图的SELECT语句后的字段列表中使用了 数学表达式 或 子查询 ，视图将不支持INSERT，也 不支持UPDATE使用了数学表达式、子查询的字段值； 
- 在定义视图的SELECT语句后的字段列表中使用 DISTINCT 、 聚合函数 、 GROUP BY 、 HAVING 、 UNION 等，视图将不支持INSERT、UPDATE、DELETE； 
- 在定义视图的SELECT语句中包含了子查询，而子查询中引用了FROM后面的表，视图将不支持 INSERT、UPDATE、DELETE； 
- 视图定义基于一个 不可更新视图 ； 常量视图。

> 虽然可以更新视图数据，但总的来说，视图作为虚拟表 ，主要用于方便查询 ，不建议更新视图的数据。对视图数据的更改，都是通过对实际数据表里数据的操作来完成的。


### 修改视图

方式1：使用CREATE OR REPLACE VIEW 子句修改视图

```mysql
CREATE OR REPLACE VIEW empvu80
(id_number, name, sal, department_id)
AS
SELECT employee_id, first_name || ' ' || last_name, salary, department_id
FROM employees
WHERE department_id = 80;

```

> 说明：CREATE VIEW 子句中各列的别名应和子查询中各列相对应。


方式2：ALTER VIEW

修改视图的语法是：

```mysql
ALTER VIEW 视图名称
AS
查询语句

```

### 删除视图

- 删除视图只是删除视图的定义，并不会删除基表的数据。 
- 删除视图的语法是：

```mysql
DROP VIEW IF EXISTS 视图名称;
```

- 举例：

```mysql
DROP VIEW empvu80;
```

- 说明：基于视图a、b创建了新的视图c，如果将视图a或者视图b删除，会导致视图c的查询失败。这 样的视图c需要手动删除或修改，否则影响使用。

### 优点

**1. 操作简单**

将经常使用的查询操作定义为视图，可以使开发人员不需要关心视图对应的数据表的结构、表与表之间的关联关系，也不需要关心数据表之间的业务逻辑和查询条件，而只需要简单地操作视图即可，极大简化了开发人员对数据库的操作。

**2. 减少数据冗余**

视图跟实际数据表不一样，它存储的是查询语句。所以，在使用的时候，我们要通过定义视图的查询语 句来获取结果集。而视图本身不存储数据，不占用数据存储的资源，减少了数据冗余。

**3. 数据安全**

MySQL将用户对数据的 访问限制 在某些数据的结果集上，而这些数据的结果集可以使用视图来实现。用 户不必直接查询或操作数据表。这也可以理解为视图具有 隔离性 。视图相当于在用户和实际的数据表之间加了一层虚拟表。

同时，MySQL可以根据权限将用户对数据的访问限制在某些视图上，用户不需要查询数据表，可以直接通过视图获取数据表中的信息。这在一定程度上保障了数据表中数据的安全性。

**4. 适应灵活多变的需求**

当业务系统的需求发生变化后，如果需要改动数据表的结构，则工作量相对较 大，可以使用视图来减少改动的工作量。这种方式在实际工作中使用得比较多。

**5. 能够分解复杂的查询逻辑**

 数据库中如果存在复杂的查询逻辑，则可以将问题进行分解，创建多个视图 获取数据，再将创建的多个视图结合起来，完成复杂的查询逻辑。

### 不足

如果我们在实际数据表的基础上创建了视图，那么，如果实际数据表的结构变更了，我们就需要及时对相关的视图进行相应的维护。特别是嵌套的视图（就是在视图的基础上创建视图），维护会变得比较复杂， 可读性不好 ，容易变成系统的潜在隐患。因为创建视图的 SQL 查询可能会对字段重命名，也可能包含复杂的逻辑，这些都会增加维护的成本。 

实际项目中，如果视图过多，会导致数据库维护成本的问题。 

所以，在创建视图的时候，你要结合实际项目需求，综合考虑视图的优点和不足，这样才能正确使用视图，使系统整体达到最优。

# other

## 导入现有表数据

```mysql
source 文件绝对路径
source  D:/masqldb.sql
```

## 关系型数据库和非关系型数据库

关系型数据库使用表格的形式来组织数据，数据以行和列的形式存储

非关系型,通常采用键值对等方式存储数据,性能较高

## 使mysql可以存中文

```mysql
//如果是修改my.ini文件前建的数据库,通过如下方式修改
alter database/table 数据库/表名 charset utf8

//mysql默认数据库的char类型只能存拉丁文,需要进行修改支持utf-8
//修改mysql的数据目录下的my.ini配置文件
//在[mysql]下添加如下
default-character-set=utf8
//在[mysqld]下添加入下
character-set-server=utf8
collation-server=utf8_general_ci


//other
show variables like 'character_%'; //查询字符集
show variables like 'collation_%'; //查询字符集比较规则
```

## 可视化工具报密码格式错误

```mysql
//因为MySQL8之前的版本中加密规则是mysql_native_password，在MySQL8之后，加密规则是caching_sha2_password

//要么升级,要么把密码加密规则还原
//修改'root'@'localhost'用户的密码规则和密码
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '新密码';
#刷新权限
FLUSH PRIVILEGES;
```

## 面试知识

### 说说你对DB、DBMS、SQL的理解

```mysql
DB就是database,也就是数据库文件
DBMS就是DB的管理工具
SQL是一门语言
mysql数据库服务器中安装了mysql DBMS来管理和操作DB,使用的sql语言

```

### 表和表记录之间的关联关系

```mysql
ORM思想(了解)
//也就是表的数据可以引用多个表的数据(n对n),也可以引用自己表中的数据(子引用)
一对一,一对多,多对多,自引用

```

### 知道哪些非关系型数据库(了解)

```mysql
redis

```

# 第15章_存储过程与函数

一组 预先编译的 SQL 语句 的封装,存在sql服务器中,需要用时,直接命令调用,减少传输量(不用传复杂的sql语句了)

好处:

- 1、简化操作，提高了sql语句的重用性，减少了开发程序员的压力。
- 2、减少操作过程中的失误，提高效率。
- 3、减少网络传输量（客户端不需要把所有的 SQL 语句通过网络发给服务器）。
- 4、减少了 SQL 语句暴露在 网上的风险，也提高了数据查询的安全性。

## 存储过程

存储过程的参数类型分为 IN(入参),OUT(返回值),INOUT(有入参且有返回值),

分类如下：

1、没有参数（无参数无返回） 

2、仅仅带 IN 类型（有参数无返回） 

3、仅仅带 OUT 类型（无参数有返回） 

4、既带 IN 又带 OUT（有参数有返回） 

5、带 INOUT（有参数有返回）

注意：IN、OUT、INOUT 都可以在一个存储过程中带多个。

## 创建存储过程

### 1) 语法分析

**语法：**

```mysql
CREATE PROCEDURE 存储过程名(IN|OUT|INOUT 参数名 参数类型,...)
[characteristics ...]
BEGIN
存储过程体
END

```

**说明：**

1、参数前面的符号的意思

- IN ：当前参数为输入参数，也就是表示入参；
  
  存储过程只是读取这个参数的值。如果没有定义参数种类， 默认就是 IN ，表示输入参数。
- OUT ：当前参数为输出参数，也就是表示出参；
  
  执行完成之后，调用这个存储过程的客户端或者应用程序就可以读取这个参数返回的值了。
- INOUT ：当前参数既可以为输入参数，也可以为输出参数。

2、形参类型可以是 MySQL数据库中的任意类型。

3、characteristics 表示创建存储过程时指定的对存储过程的约束条件，其取值信息如下：

```mysql
LANGUAGE SQL
| [NOT] DETERMINISTIC
| { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
| SQL SECURITY { DEFINER | INVOKER }
| COMMENT 'string'

```

- LANGUAGE SQL ：说明存储过程执行体是由SQL语句组成的，当前系统支持的语言为SQL。
- [NOT] DETERMINISTIC ：指明存储过程执行的结果是否确定。DETERMINISTIC表示结果是确定 的。每次执行存储过程时，相同的输入会得到相同的输出。NOT DETERMINISTIC表示结果是不确定 的，相同的输入可能得到不同的输出。如果没有指定任意一个值，默认为NOT DETERMINISTIC。
- { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA } ：指明子程序使 用SQL语句的限制。
  - CONTAINS SQL表示当前存储过程的子程序包含SQL语句，但是并不包含读写数据的SQL语句；
  - NO SQL表示当前存储过程的子程序中不包含任何SQL语句； 
  - READS SQL DATA表示当前存储过程的子程序中包含读数据的SQL语句； 
  - MODIFIES SQL DATA表示当前存储过程的子程序中包含写数据的SQL语句。 
  - 默认情况下，系统会指定为CONTAINS SQL。
- SQL SECURITY { DEFINER | INVOKER } ：执行当前存储过程的权限，即指明哪些用户能够执行当前存储过程。
  - DEFINER 表示只有当前存储过程的创建者或者定义者才能执行当前存储过程；
  - INVOKER 表示拥有当前存储过程的访问权限的用户能够执行当前存储过程。
- COMMENT 'string' ：注释信息，可以用来描述存储过程。

4、存储过程体中可以有多条 SQL 语句，如果仅仅一条SQL 语句，则可以省略 BEGIN 和 END

```mysql
1. BEGIN…END：BEGIN…END 中间包含了多个语句，每个语句都以（;）号为结束符。
2. DECLARE：DECLARE 用来声明变量，使用的位置在于 BEGIN…END 语句中间，而且需要在其他语句使用之前进
行变量的声明。
3. SET：赋值语句，用于对变量进行赋值。
4. SELECT… INTO：把从数据表中查询的结果存放到变量中，也就是为变量赋值。

```

5、需要设置新的结束标记

```mysql
DELIMITER 新的结束标记

```

因为MySQL默认的语句结束符号为分号‘;’。为了避免与存储过程中SQL语句结束符相冲突，需要使用 DELIMITER改变存储过程的结束符。

比如：“DELIMITER //”语句的作用是将MySQL的结束符设置为//，并以“END //”结束存储过程。存储过程定 义完毕之后再使用“DELIMITER ;”恢复默认结束符。DELIMITER也可以指定其他符号作为结束符。

当使用DELIMITER命令时，应该避免使用反斜杠（‘\’）字符，因为反斜线是MySQL的转义字符。 

示例：

```mysql
DELIMITER $
CREATE PROCEDURE 存储过程名(IN|OUT|INOUT 参数名 参数类型,...)
[characteristics ...]
BEGIN
sql语句1;
sql语句2;
END $

```

### 2)  代码举例

举例1：创建存储过程select_all_data()，查看 emps 表的所有数据

```mysql
DELIMITER $
CREATE PROCEDURE select_all_data()
BEGIN
SELECT * FROM emps;
END $
DELIMITER ;

```

举例2：创建存储过程avg_employee_salary()，返回所有员工的平均工资

```mysql
DELIMITER //
CREATE PROCEDURE avg_employee_salary ()
BEGIN
SELECT AVG(salary) AS avg_salary FROM emps;
END //
DELIMITER ;

```

## 3. 调用存储过程

### 1) 调用格式

存储过程有多种调用方法。存储过程必须使用CALL语句调用，并且存储过程和数据库相关，如果要执行其他数据库中的存储过程，需要指定数据库名称，例如CALL dbname.procname。

```mysql
CALL 存储过程名(实参列表)
```

**格式：**

1、调用in模式的参数：

```mysql
CALL sp1('值');
```

2、调用out模式的参数：

```mysql
SET @name;
CALL sp1(@name);
SELECT @name;
```

3、调用inout模式的参数：

```mysql
SET @name=值;
CALL sp1(@name);
SELECT @name;
```

### 2) 代码举例 

**举例1：**

```mysql
DELIMITER //
CREATE PROCEDURE CountProc(IN sid INT,OUT num INT)
BEGIN
SELECT COUNT(*) INTO num FROM fruits
WHERE s_id = sid;
END //
DELIMITER ;
```

调用存储过程：

```mysql
CALL CountProc (101, @num);
```

查看返回结果：

```mysql
SELECT @num;
```

**举例2：**创建存储过程，实现累加运算，计算 1+2+…+n 等于多少。具体的代码如下：

```mysql
DELIMITER //
CREATE PROCEDURE `add_num`(IN n INT)
BEGIN
DECLARE i INT;
DECLARE sum INT;
SET i = 1;
SET sum = 0;
WHILE i <= n DO
SET sum = sum + i;
SET i = i +1;
END WHILE;
SELECT sum;
END //
DELIMITER ;
```

直接使用 CALL add_num(50); 即可。这里我传入的参数为 50，也就是统计 1+2+…+50 的积累之和。

### 3) 如何调试

在 MySQL 中，存储过程不像普通的编程语言（比如 VC++、Java 等）那样有专门的集成开发环境。因 此，你可以通过 SELECT 语句，把程序执行的中间结果查询出来，来调试一个 SQL 语句的正确性。调试 成功之后，把 SELECT 语句后移到下一个 SQL 语句之后，再调试下一个 SQL 语句。这样 逐步推进 ，就可以完成对存储过程中所有操作的调试了。当然，你也可以把存储过程中的 SQL 语句复制出来，逐段单独 调试。

## 4. 存储函数的使用

### 1) 语法分析

学过的函数：LENGTH、SUBSTR、CONCAT等

语法格式：

```mysql
CREATE FUNCTION 函数名(参数名 参数类型,...)
RETURNS 返回值类型
[characteristics ...]
BEGIN
函数体 #函数体中肯定有 RETURN 语句
END
```

说明：

1、参数列表：指定参数为IN、OUT或INOUT只对PROCEDURE是合法的，FUNCTION中总是默认为IN参数。 

2、RETURNS type 语句表示函数返回数据的类型； RETURNS子句只能对FUNCTION做指定，对函数而言这是 强制 的。它用来指定函数的返回类型，而且函 数体必须包含一个 RETURN value 语句。 

3、characteristic 创建函数时指定的对函数的约束。取值与创建存储过程时相同，这里不再赘述。 

4、函数体也可以用BEGIN…END来表示SQL代码的开始和结束。如果函数体只有一条语句，也可以省略 BEGIN…END。

### 2) 调用存储函数

在MySQL中，存储函数的使用方法与MySQL内部函数的使用方法是一样的。换言之，用户自己定义的存储函数与MySQL内部函数是一个性质的。区别在于，存储函数是 用户自己定义 的，而内部函数是MySQL 的 开发者定义 的。

```mysql
SELECT 函数名(实参列表)
```

### 3) 代码举例

**举例1：**

创建存储函数，名称为email_by_name()，参数定义为空，该函数查询Abel的email，并返回，数据类型为字符串型。

```mysql
DELIMITER //
CREATE FUNCTION email_by_name()
RETURNS VARCHAR(25)
DETERMINISTIC
CONTAINS SQL
BEGIN
RETURN (SELECT email FROM employees WHERE last_name = 'Abel');
END //
DELIMITER ;
```

调用：

```mysql
SELECT email_by_name();
```

**举例2：**

创建存储函数，名称为email_by_id()，参数传入emp_id，该函数查询emp_id的email，并返回，数据类型 为字符串型。

```mysql
DELIMITER //
CREATE FUNCTION email_by_id(emp_id INT)
RETURNS VARCHAR(25)
DETERMINISTIC
CONTAINS SQL
BEGIN
RETURN (SELECT email FROM employees WHERE employee_id = emp_id);
END //
DELIMITER ;
```

调用：

```mysql
SET @emp_id = 102;
SELECT email_by_id(@emp_id);
```

**注意：**

若在创建存储函数中报错“ you might want to use the less safe log_bin_trust_function_creators variable ”，有两种处理方法：

- 方式1：
  
  加上必要的函数特性“[NOT] DETERMINISTIC”和“{CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA}”
- 方式2：

```mysql
SET GLOBAL log_bin_trust_function_creators = 1;
```

### 4) 对比存储函数与存储过程

||关键字|调用语法|返回值|应用场景|
|--|--|--|--|--|
|存储过程|PROCEDURE|CALL 存储过程()|理解为有0个或多个|一般用于更新|
|存储函数|FUNCTION|SELECT 函数 ()|只能是一个|一般用于查询结果为一个值并返回时|

此外，**存储函数可以放在查询语句中使用，存储过程不行**。反之，存储过程的功能更加强大，包括能够 执行对表的操作（比如创建表，删除表等）和事务操作，这些功能是存储函数不具备的。

## 5. 存储过程和函数的查看、修改、删除

### 1) 查看

 创建完之后，怎么知道我们创建的存储过程、存储函数是否成功了呢？

MySQL存储了存储过程和函数的状态信息，用户可以使用SHOW STATUS语句或SHOW CREATE语句来查 看，也可直接从系统的information_schema数据库中查询。这里介绍3种方法。

1. 使用SHOW CREATE语句查看存储过程和函数的创建信息

```mysql
SHOW CREATE {PROCEDURE | FUNCTION} 存储过程名或函数名
```

2. 使用SHOW STATUS语句查看存储过程和函数的状态信息

```mysql
SHOW {PROCEDURE | FUNCTION} STATUS [LIKE 'pattern']
```

3. 从information_schema.Routines表中查看存储过程和函数的信息

MySQL中存储过程和函数的信息存储在information_schema数据库下的Routines表中。可以通过查询该表的记录来查询存储过程和函数的信息。其基本语法形式如下：

```mysql
SELECT * FROM information_schema.Routines
WHERE ROUTINE_NAME='存储过程或函数的名' [AND ROUTINE_TYPE = {'PROCEDURE|FUNCTION'}];
```

说明：如果在MySQL数据库中存在存储过程和函数名称相同的情况，最好指定ROUTINE_TYPE查询条件来 指明查询的是存储过程还是函数。

### 2) 修改

修改存储过程或函数，不影响存储过程或函数功能，只是修改相关特性。使用ALTER语句实现。

```mysql
ALTER {PROCEDURE | FUNCTION} 存储过程或函数的名 [characteristic ...]
```

其中，characteristic指定存储过程或函数的特性，其取值信息与创建存储过程、函数时的取值信息略有不同。

```mysql
{ CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
| SQL SECURITY { DEFINER | INVOKER }
| COMMENT 'string'
```

- CONTAINS SQL ，表示子程序包含SQL语句，但不包含读或写数据的语句。 
- NO SQL ，表示子程序中不包含SQL语句。 
- READS SQL DATA ，表示子程序中包含读数据的语句。 
- MODIFIES SQL DATA ，表示子程序中包含写数据的语句。 
- SQL SECURITY { DEFINER | INVOKER } ，指明谁有权限来执行。 
  - DEFINER ，表示只有定义者自己才能够执行。 
  - INVOKER ，表示调用者可以执行。
- COMMENT 'string' ，表示注释信息。

> 修改存储过程使用ALTER PROCEDURE语句，修改存储函数使用ALTER FUNCTION语句。但是，这两 个语句的结构是一样的，语句中的所有参数也是一样的。

### 3) 删除

删除存储过程和函数，可以使用DROP语句，其语法结构如下：

```mysql
DROP {PROCEDURE | FUNCTION} [IF EXISTS] 存储过程或函数的名
```

## 6. 关于存储过程使用的争议

### 1) 优点

1、存储过程可以一次编译多次使用。存储过程只在创建时进行编译，之后的使用都不需要重新编译， 这就提升了 SQL 的执行效率。

2、可以减少开发工作量。将代码 封装 成模块，实际上是编程的核心思想之一，这样可以把复杂的问题 拆解成不同的模块，然后模块之间可以 重复使用 ，在减少开发工作量的同时，还能保证代码的结构清 晰。 

3、存储过程的安全性强。我们在设定存储过程的时候可以 设置对用户的使用权限 ，这样就和视图一样具 有较强的安全性。 

4、可以减少网络传输量。因为代码封装到存储过程中，每次使用只需要调用存储过程即可，这样就减 少了网络传输量。 

5、良好的封装性。在进行相对复杂的数据库操作时，原本需要使用一条一条的 SQL 语句，可能要连接 多次数据库才能完成的操作，现在变成了一次存储过程，只需要 连接一次即可 。

### 2) 缺点

> 阿里开发规范 【强制】禁止使用存储过程，存储过程难以调试和扩展，更没有移植性。

1、可移植性差。存储过程不能跨数据库移植，比如在 MySQL、Oracle 和 SQL Server 里编写的存储过 程，在换成其他数据库时都需要重新编写。 

2、调试困难。只有少数 DBMS 支持存储过程的调试。对于复杂的存储过程来说，开发和维护都不容 易。虽然也有一些第三方工具可以对存储过程进行调试，但要收费。 

3、存储过程的版本管理很困难。比如数据表索引发生变化了，可能会导致存储过程失效。我们在开发 软件的时候往往需要进行版本管理，但是存储过程本身没有版本控制，版本迭代更新的时候很麻烦。 

4、它不适合高并发的场景。高并发的场景需要减少数据库的压力，有时数据库会采用分库分表的方式，而且对可扩展性要求很高，在这种情况下，存储过程会变得难以维护， 增加数据库的压力 ，显然就不适用了。

### 3) 小结

存储过程既方便，又有局限性。尽管不同的公司对存储过程的态度不一，但是对于我们开发人员来说， 不论怎样，掌握存储过程都是必备的技能之一。

# 第16章_变量、流程控制与游标

在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终的结果数据。

## 1. 变量

在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终 的结果数据。 

在 MySQL 数据库中，变量分为 系统变量 以及 用户自定义变量 。

### 1) 系统变量

**系统变量分类**

变量由系统定义，不是用户定义，属于 服务器 层面。启动MySQL服务，生成MySQL服务实例期间， MySQL将为MySQL服务器内存中的系统变量赋值，这些系统变量定义了当前MySQL服务实例的属性、特 征。这些系统变量的值要么是 编译MySQL时参数 的默认值，要么是 配置文件 （例如my.ini等）中的参数 值。大家可以通过网址 https://dev.mysql.com/doc/refman/8.0/en/server-systemvariables.html 查看MySQL文档的系统变量。

系统变量分为全局系统变量（需要添加 global 关键字）以及会话系统变量（需要添加 session 关键字），有时也把全局系统变量简称为全局变量，有时也把会话系统变量称为local变量。如果不写，默认会话级别。静态变量（在 MySQL 服务实例运行期间它们的值不能使用 set 动态修改）属于特殊的全局系统变量。

每一个MySQL客户机成功连接MySQL服务器后，都会产生与之对应的会话。会话期间，MySQL服务实例会在MySQL服务器内存中生成与该会话对应的会话系统变量，这些会话系统变量的初始值是全局系统变量值的复制。如下图：
![[Pasted image 20240918171737.png]]
6. 关于存储过程使用的争议

### 1) 优点

1、存储过程可以一次编译多次使用。存储过程只在创建时进行编译，之后的使用都不需要重新编译， 这就提升了 SQL 的执行效率。

2、可以减少开发工作量。将代码 封装 成模块，实际上是编程的核心思想之一，这样可以把复杂的问题 拆解成不同的模块，然后模块之间可以 重复使用 ，在减少开发工作量的同时，还能保证代码的结构清 晰。 

3、存储过程的安全性强。我们在设定存储过程的时候可以 设置对用户的使用权限 ，这样就和视图一样具 有较强的安全性。 

4、可以减少网络传输量。因为代码封装到存储过程中，每次使用只需要调用存储过程即可，这样就减 少了网络传输量。 

5、良好的封装性。在进行相对复杂的数据库操作时，原本需要使用一条一条的 SQL 语句，可能要连接 多次数据库才能完成的操作，现在变成了一次存储过程，只需要 连接一次即可 。

### 2) 缺点

> 阿里开发规范 【强制】禁止使用存储过程，存储过程难以调试和扩展，更没有移植性。


1、可移植性差。存储过程不能跨数据库移植，比如在 MySQL、Oracle 和 SQL Server 里编写的存储过 程，在换成其他数据库时都需要重新编写。 

2、调试困难。只有少数 DBMS 支持存储过程的调试。对于复杂的存储过程来说，开发和维护都不容 易。虽然也有一些第三方工具可以对存储过程进行调试，但要收费。 

3、存储过程的版本管理很困难。比如数据表索引发生变化了，可能会导致存储过程失效。我们在开发 软件的时候往往需要进行版本管理，但是存储过程本身没有版本控制，版本迭代更新的时候很麻烦。 

4、它不适合高并发的场景。高并发的场景需要减少数据库的压力，有时数据库会采用分库分表的方式，而且对可扩展性要求很高，在这种情况下，存储过程会变得难以维护， 增加数据库的压力 ，显然就不适用了。

### 3) 小结

存储过程既方便，又有局限性。尽管不同的公司对存储过程的态度不一，但是对于我们开发人员来说， 不论怎样，掌握存储过程都是必备的技能之一。

# 第16章_变量、流程控制与游标

在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终的结果数据。

## 1. 变量

在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终 的结果数据。 

在 MySQL 数据库中，变量分为 系统变量 以及 用户自定义变量 。

### 1) 系统变量

**系统变量分类**

变量由系统定义，不是用户定义，属于 服务器 层面。启动MySQL服务，生成MySQL服务实例期间， MySQL将为MySQL服务器内存中的系统变量赋值，这些系统变量定义了当前MySQL服务实例的属性、特 征。这些系统变量的值要么是 编译MySQL时参数 的默认值，要么是 配置文件 （例如my.ini等）中的参数 值。大家可以通过网址 [https://dev.mysql.com/doc/refman/8.0/en/server-systemvariables.html](https://dev.mysql.com/doc/refman/8.0/en/server-systemvariables.html) 查看MySQL文档的系统变量。

系统变量分为全局系统变量（需要添加 global 关键字）以及会话系统变量（需要添加 session 关键字），有时也把全局系统变量简称为全局变量，有时也把会话系统变量称为local变量。如果不写，默认会话级别。静态变量（在 MySQL 服务实例运行期间它们的值不能使用 set 动态修改）属于特殊的全局系统变量。

每一个MySQL客户机成功连接MySQL服务器后，都会产生与之对应的会话。会话期间，MySQL服务实例会在MySQL服务器内存中生成与该会话对应的会话系统变量，这些会话系统变量的初始值是全局系统变量值的复制。如下图：

![](file://E:/%E9%9C%80%E5%90%8C%E6%AD%A5/%E6%88%91%E7%9A%84%E5%9D%9A%E6%9E%9C%E4%BA%91/mysql/MySQL%E5%9F%BA%E7%A1%80%E7%AF%87.assets/image-20220613135809104.png?lastModify=1710939852)

- 全局系统变量针对于所有会话（连接）有效，但 不能跨重启

- 会话系统变量仅针对于当前会话（连接）有效。会话期间，当前会话对某个会话系统变量值的修改，不会影响其他会话同一个会话系统变量的值。 

- 会话1对某个全局系统变量值的修改会导致会话2中同一个全局系统变量值的修改。

在MySQL中有些系统变量只能是全局的，例如 max_connections 用于限制服务器的最大连接数；有些系 统变量作用域既可以是全局又可以是会话，例如 character_set_client 用于设置客户端的字符集；有些系 统变量的作用域只能是当前会话，例如 pseudo_thread_id 用于标记当前会话的 MySQL 连接 ID。

**查看系统变量**

- 查看所有或部分系统变量

```
#查看所有全局变量
SHOW GLOBAL VARIABLES;
#查看所有会话变量
SHOW SESSION VARIABLES;
或
SHOW VARIABLES;

```

```
#查看满足条件的部分系统变量。
SHOW GLOBAL VARIABLES LIKE '%标识符%';
#查看满足条件的部分会话变量
SHOW SESSION VARIABLES LIKE '%标识符%';

```

**查看指定系统变量**

作为 MySQL 编码规范，MySQL 中的系统变量以 两个“@” 开头，其中“@@global”仅用于标记全局系统变量，“@@session”仅用于标记会话系统变量。“@@”首先标记会话系统变量，如果会话系统变量不存在， 则标记全局系统变量。

```
#查看指定的系统变量的值
SELECT @@global.变量名;
#查看指定的会话变量的值
SELECT @@session.变量名;
#或者
SELECT @@变量名;

```

**修改系统变量的值**

有些时候，数据库管理员需要修改系统变量的默认值，以便修改当前会话或者MySQL服务实例的属性、 特征。具体方法：

方式1：修改MySQL 配置文件 ，继而修改MySQL系统变量的值（该方法需要重启MySQL服务） 

方式2：在MySQL服务运行期间，使用“set”命令重新设置系统变量的值

```
#为某个系统变量赋值
#方式1：
SET @@global.变量名=变量值;
#方式2：
SET GLOBAL 变量名=变量值;
#为某个会话变量赋值
#方式1：
SET @@session.变量名=变量值;
#方式2：
SET SESSION 变量名=变量值;

```

### 2) 用户变量

**用户变量分类**

用户变量是用户自己定义的，作为 MySQL 编码规范，MySQL 中的用户变量以一个“@” 开头。根据作用范围不同，又分为 会话用户变量 和 局部变量 。 

- 会话用户变量：作用域和会话变量一样，只对 当前连接 会话有效。 

- 局部变量：只在 BEGIN 和 END 语句块中有效。局部变量只能在 存储过程和函数 中使用。

**会话用户变量**

- 变量的定义

```
#方式1：“=”或“:=”
SET @用户变量 = 值;
SET @用户变量 := 值;
#方式2：“:=” 或 INTO关键字
SELECT @用户变量 := 表达式 [FROM 等子句];
SELECT 表达式 INTO @用户变量 [FROM 等子句];

```

- 查看用户变量的值 (查看、比较、运算等)

```
SELECT @用户变量

```

**局部变量**

定义：可以使用 DECLARE 语句定义一个局部变量 

作用域：仅仅在定义它的 BEGIN ... END 中有效 

位置：只能放在 BEGIN ... END 中，而且只能放在第一句

```
BEGIN
#声明局部变量
DECLARE 变量名1 变量数据类型 [DEFAULT 变量默认值];
DECLARE 变量名2,变量名3,... 变量数据类型 [DEFAULT 变量默认值];
#为局部变量赋值
SET 变量名1 = 值;
SELECT 值 INTO 变量名2 [FROM 子句];
#查看局部变量的值
SELECT 变量1,变量2,变量3;
END

```

1. 定义变量

```
DECLARE 变量名 类型 [default 值]; # 如果没有DEFAULT子句，初始值为NULL

```

1. 变量赋值

方式1：一般用于赋简单的值

```
SET 变量名=值;
SET 变量名:=值;

```

方式2：一般用于赋表中的字段值

```
SELECT 字段名或表达式 INTO 变量名 FROM 表;

```

1. 使用变量 (查看、比较、运算等)

```
SELECT 局部变量名;

```

举例1：声明局部变量，并分别赋值为employees表中employee_id为102的last_name和salary

```
DELIMITER //
CREATE PROCEDURE set_value()
BEGIN
DECLARE emp_name VARCHAR(25);
DECLARE sal DOUBLE(10,2);
SELECT last_name, salary INTO emp_name,sal
FROM employees
WHERE employee_id = 102;
SELECT emp_name, sal;
END //
DELIMITER ;

```

举例2：声明两个变量，求和并打印 （分别使用会话用户变量、局部变量的方式实现）

```
#方式1：使用用户变量
SET @m=1;
SET @n=1;
SET @sum=@m+@n;
SELECT @sum;

```

```
#方式2：使用局部变量
DELIMITER //
CREATE PROCEDURE add_value()
BEGIN
#局部变量
DECLARE m INT DEFAULT 1;
DECLARE n INT DEFAULT 3;
DECLARE SUM INT;
SET SUM = m+n;
SELECT SUM;
END //
DELIMITER ;

```

**对比会话用户变量与局部变量**

|   | 作用域 | 定义位置 | 语法 | 
| -- | -- | -- | -- |
| 会话用户变量 | 当前会话 | 会话的任何地方 | 加@符号，不用指定类型 | 
| 局部变量 | 定义它的BEGIN END中 | BEGIN END的第一句话 | 一般不用加@,需要指定类型 | 


## 2. 定义条件与处理程序

定义条件 是事先定义程序执行过程中可能遇到的问题， 处理程序 定义了在遇到问题时应当采取的处理方式，并且保证存储过程或函数在遇到警告或错误时能继续执行。这样可以增强存储程序处理问题的能力，避免程序异常停止运行。

说明：定义条件和处理程序在存储过程、存储函数中都是支持的。

### 1) 案例分析

案例分析：创建一个名称为“UpdateDataNoCondition”的存储过程。代码如下：

```
DELIMITER //
CREATE PROCEDURE UpdateDataNoCondition()
BEGIN
SET @x = 1;
UPDATE employees SET email = NULL WHERE last_name = 'Abel';
SET @x = 2;
UPDATE employees SET email = 'aabbel' WHERE last_name = 'Abel';
SET @x = 3;
END //
DELIMITER ;

```

调用存储过程：

```
mysql> CALL UpdateDataNoCondition();
ERROR 1048 (23000): Column 'email' cannot be null
mysql> SELECT @x;
+------+
| @x |
+------+
| 1 |
+------+
1 row in set (0.00 sec)

```

可以看到，此时@x变量的值为1。结合创建存储过程的SQL语句代码可以得出：在存储过程中未定义条件 和处理程序，且当存储过程中执行的SQL语句报错时，MySQL数据库会抛出错误，并退出当前SQL逻辑， 不再向下继续执行。

### 2) 定义条件

定义条件就是给MySQL中的错误码命名，这有助于存储的程序代码更清晰。它将一个 错误名字 和 指定的 错误条件 关联起来。这个名字可以随后被用在定义处理程序的 DECLARE HANDLER 语句中。

定义条件使用DECLARE语句，语法格式如下：

```
DECLARE 错误名称 CONDITION FOR 错误码（或错误条件）

```

错误码的说明：

- MySQL_error_code 和 sqlstate_value 都可以表示MySQL的错误。

- MySQL_error_code是数值类型错误代码。 

- sqlstate_value是长度为5的字符串类型错误代码。 

例如，在ERROR 1418 (HY000)中，1418是MySQL_error_code，'HY000'是sqlstate_value。 

例如，在ERROR 1142（42000）中，1142是MySQL_error_code，'42000'是sqlstate_value。

举例1：定义“Field_Not_Be_NULL”错误名与MySQL中违反非空约束的错误类型是“ERROR 1048 (23000)”对应。

```
#使用MySQL_error_code
DECLARE Field_Not_Be_NULL CONDITION FOR 1048;
#使用sqlstate_value
DECLARE Field_Not_Be_NULL CONDITION FOR SQLSTATE '23000';

```

### 3) 定义处理程序

可以为SQL执行过程中发生的某种类型的错误定义特殊的处理程序。定义处理程序时，使用DECLARE语句 的语法如下：

```
DECLARE 处理方式 HANDLER FOR 错误类型 处理语句

```

- 处理方式：处理方式有3个取值：CONTINUE、EXIT、UNDO。

- CONTINUE ：表示遇到错误不处理，继续执行。

- EXIT ：表示遇到错误马上退出。

- UNDO ：表示遇到错误后撤回之前的操作。MySQL中暂时不支持这样的操作。

- 错误类型（即条件）可以有如下取值：

- SQLSTATE '字符串错误码' ：表示长度为5的sqlstate_value类型的错误代码； 

- MySQL_error_code ：匹配数值类型错误代码； 

- 错误名称 ：表示DECLARE ... CONDITION定义的错误条件名称。 

- SQLWARNING ：匹配所有以01开头的SQLSTATE错误代码； 

- NOT FOUND ：匹配所有以02开头的SQLSTATE错误代码； 

- SQLEXCEPTION ：匹配所有没有被SQLWARNING或NOT FOUND捕获的SQLSTATE错误代码；

- 处理语句：如果出现上述条件之一，则采用对应的处理方式，并执行指定的处理语句。语句可以是 像“ SET 变量 = 值 ”这样的简单语句，也可以是使用 BEGIN ... END 编写的复合语句。

定义处理程序的几种方式，代码如下：

```
#方法1：捕获sqlstate_value
DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @info = 'NO_SUCH_TABLE';
#方法2：捕获mysql_error_value
DECLARE CONTINUE HANDLER FOR 1146 SET @info = 'NO_SUCH_TABLE';
#方法3：先定义条件，再调用
DECLARE no_such_table CONDITION FOR 1146;
DECLARE CONTINUE HANDLER FOR NO_SUCH_TABLE SET @info = 'NO_SUCH_TABLE';
#方法4：使用SQLWARNING
DECLARE EXIT HANDLER FOR SQLWARNING SET @info = 'ERROR';
#方法5：使用NOT FOUND
DECLARE EXIT HANDLER FOR NOT FOUND SET @info = 'NO_SUCH_TABLE';
#方法6：使用SQLEXCEPTION
DECLARE EXIT HANDLER FOR SQLEXCEPTION SET @info = 'ERROR';

```

### 4) 案例解决

在存储过程中，定义处理程序，捕获sqlstate_value值，当遇到MySQL_error_code值为1048时，执行 CONTINUE操作，并且将@proc_value的值设置为-1。

```
DELIMITER //
CREATE PROCEDURE UpdateDataNoCondition()
BEGIN
    #定义处理程序
    DECLARE CONTINUE HANDLER FOR 1048 SET @proc_value = -1;
    SET @x = 1;
    UPDATE employees SET email = NULL WHERE last_name = 'Abel';
    SET @x = 2;
    UPDATE employees SET email = 'aabbel' WHERE last_name = 'Abel';
    SET @x = 3;
END //
DELIMITER ;

```

## 3. 流程控制

解决复杂问题不可能通过一个 SQL 语句完成，我们需要执行多个 SQL 操作。流程控制语句的作用就是控 制存储过程中 SQL 语句的执行顺序，是我们完成复杂操作必不可少的一部分。只要是执行的程序，流程就分为三大类：

- 顺序结构 ：程序从上往下依次执行 

- 分支结构 ：程序按条件进行选择执行，从两条或多条路径中选择一条执行 

- 循环结构 ：程序满足一定条件下，重复执行一组语句

针对于MySQL 的流程控制语句主要有 3 类。注意：只能用于存储程序。

- 条件判断语句 ：IF 语句和 CASE 语句 

- 循环语句 ：LOOP、WHILE 和 REPEAT 语句 

- 跳转语句 ：ITERATE 和 LEAVE 语句

### 1) 分支结构之 IF

- IF 语句的语法结构是：

```
IF 表达式1 THEN 操作1
[ELSEIF 表达式2 THEN 操作2]……
[ELSE 操作N]
END IF

```

根据表达式的结果为TRUE或FALSE执行相应的语句。这里“[]”中的内容是可选的。

- 特点：① 不同的表达式对应不同的操作 ② 使用在begin end中

- 举例1：

```
IF val IS NULL
	THEN SELECT 'val is null';
ELSE SELECT 'val is not null';
END IF;

```

- 举例2：声明存储过程“update_salary_by_eid1”，定义IN参数emp_id，输入员工编号。判断该员工薪资如果低于8000元并且入职时间超过5年，就涨薪500元；否则就不变。

```
DELIMITER //
CREATE PROCEDURE update_salary_by_eid1(IN emp_id INT)
BEGIN
    DECLARE emp_salary DOUBLE;
    DECLARE hire_year DOUBLE;
    SELECT salary INTO emp_salary FROM employees WHERE employee_id = emp_id;
    SELECT DATEDIFF(CURDATE(),hire_date)/365 INTO hire_year
    FROM employees WHERE employee_id = emp_id;
    IF emp_salary < 8000 AND hire_year > 5
    THEN UPDATE employees SET salary = salary + 500 WHERE employee_id = emp_id;
    END IF;
END //
DELIMITER ;

```

### 2) 分支结构之 CASE

- CASE 语句的语法结构1：

```
#情况一：类似于switch
CASE 表达式
WHEN 值1 THEN 结果1或语句1(如果是语句，需要加分号)
WHEN 值2 THEN 结果2或语句2(如果是语句，需要加分号)
...
ELSE 结果n或语句n(如果是语句，需要加分号)
END [case]（如果是放在begin end中需要加上case，如果放在select后面不需要）

```

- CASE 语句的语法结构2：

```
#情况二：类似于多重if
CASE
WHEN 条件1 THEN 结果1或语句1(如果是语句，需要加分号)
WHEN 条件2 THEN 结果2或语句2(如果是语句，需要加分号)
...
ELSE 结果n或语句n(如果是语句，需要加分号)
END [case]（如果是放在begin end中需要加上case，如果放在select后面不需要）

```

- 举例1：使用CASE流程控制语句的第1种格式，判断val值等于1、等于2，或者两者都不等。

```
CASE val
    WHEN 1 THEN SELECT 'val is 1';
    WHEN 2 THEN SELECT 'val is 2';
    ELSE SELECT 'val is not 1 or 2';
END CASE;

```

- 举例2：声明存储过程“update_salary_by_eid4”，定义IN参数emp_id，输入员工编号。判断该员工 薪资如果低于9000元，就更新薪资为9000元；薪资大于等于9000元且低于10000的，但是奖金比例 为NULL的，就更新奖金比例为0.01；其他的涨薪100元。

```
DELIMITER //
CREATE PROCEDURE update_salary_by_eid4(IN emp_id INT)
BEGIN
    DECLARE emp_sal DOUBLE;
    DECLARE bonus DECIMAL(3,2);
    SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;
    SELECT commission_pct INTO bonus FROM employees WHERE employee_id = emp_id;
    CASE
    WHEN emp_sal<9000
    	THEN UPDATE employees SET salary=9000 WHERE employee_id = emp_id;
    WHEN emp_sal<10000 AND bonus IS NULL
    	THEN UPDATE employees SET commission_pct=0.01 WHERE employee_id = emp_id;
    ELSE
    	UPDATE employees SET salary=salary+100 WHERE employee_id = emp_id;
    END CASE;
END //
DELIMITER ;

```

- 举例3：声明存储过程update_salary_by_eid5，定义IN参数emp_id，输入员工编号。判断该员工的 入职年限，如果是0年，薪资涨50；如果是1年，薪资涨100；如果是2年，薪资涨200；如果是3年， 薪资涨300；如果是4年，薪资涨400；其他的涨薪500。

```
DELIMITER //
CREATE PROCEDURE update_salary_by_eid5(IN emp_id INT)
BEGIN
    DECLARE emp_sal DOUBLE;
    DECLARE hire_year DOUBLE;
    SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;
    SELECT ROUND(DATEDIFF(CURDATE(),hire_date)/365) INTO hire_year FROM employees
    WHERE employee_id = emp_id;
    CASE hire_year
        WHEN 0 THEN UPDATE employees SET salary=salary+50 WHERE employee_id = emp_id;
        WHEN 1 THEN UPDATE employees SET salary=salary+100 WHERE employee_id = emp_id;
        WHEN 2 THEN UPDATE employees SET salary=salary+200 WHERE employee_id = emp_id;
        WHEN 3 THEN UPDATE employees SET salary=salary+300 WHERE employee_id = emp_id;
        WHEN 4 THEN UPDATE employees SET salary=salary+400 WHERE employee_id = emp_id;
        ELSE UPDATE employees SET salary=salary+500 WHERE employee_id = emp_id;
    END CASE;
END //
DELIMITER ;

```

### 3) 循环结构之LOOP

LOOP循环语句用来重复执行某些语句。LOOP内的语句一直重复执行直到循环被退出（使用LEAVE子 句），跳出循环过程。

LOOP语句的基本格式如下：

```
[loop_label:] LOOP
循环执行的语句
END LOOP [loop_label]

```

其中，loop_label表示LOOP语句的标注名称，该参数可以省略。

举例1：使用LOOP语句进行循环操作，id值小于10时将重复执行循环过程。

```
DECLARE id INT DEFAULT 0;
add_loop:LOOP
    SET id = id +1;
    IF id >= 10 THEN LEAVE add_loop;
    END IF;
END LOOP add_loop;

```

举例2：当市场环境变好时，公司为了奖励大家，决定给大家涨工资。声明存储过程 “update_salary_loop()”，声明OUT参数num，输出循环次数。存储过程中实现循环给大家涨薪，薪资涨为 原来的1.1倍。直到全公司的平均薪资达到12000结束。并统计循环次数。

```
DELIMITER //
CREATE PROCEDURE update_salary_loop(OUT num INT)
BEGIN
	DECLARE avg_salary DOUBLE;
	DECLARE loop_count INT DEFAULT 0;
	SELECT AVG(salary) INTO avg_salary FROM employees;
	label_loop:LOOP
        IF avg_salary >= 12000 THEN LEAVE label_loop;
        END IF;
        UPDATE employees SET salary = salary * 1.1;
        SET loop_count = loop_count + 1;
        SELECT AVG(salary) INTO avg_salary FROM employees;
    END LOOP label_loop;
    SET num = loop_count;
END //
DELIMITER ;

```

### 4) 循环结构之WHILE

WHILE语句创建一个带条件判断的循环过程。WHILE在执行语句执行时，先对指定的表达式进行判断，如 果为真，就执行循环内的语句，否则退出循环。WHILE语句的基本格式如下：

```
[while_label:] WHILE 循环条件 DO
循环体
END WHILE [while_label];

```

while_label为WHILE语句的标注名称；如果循环条件结果为真，WHILE语句内的语句或语句群被执行，直 至循环条件为假，退出循环。

- 举例1：WHILE语句示例，i值小于10时，将重复执行循环过程，代码如下：

```
DELIMITER //
CREATE PROCEDURE test_while()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 10 DO
    	SET i = i + 1;
    END WHILE;
    SELECT i;
END //
DELIMITER ;
#调用
CALL test_while();

```

- 举例2：市场环境不好时，公司为了渡过难关，决定暂时降低大家的薪资。声明存储过程 “update_salary_while()”，声明OUT参数num，输出循环次数。存储过程中实现循环给大家降薪，薪资降 为原来的90%。直到全公司的平均薪资达到5000结束。并统计循环次数。

```
DELIMITER //
CREATE PROCEDURE update_salary_while(OUT num INT)
BEGIN
    DECLARE avg_sal DOUBLE ;
    DECLARE while_count INT DEFAULT 0;
    SELECT AVG(salary) INTO avg_sal FROM employees;
    WHILE avg_sal > 5000 DO
        UPDATE employees SET salary = salary * 0.9;
        SET while_count = while_count + 1;
        SELECT AVG(salary) INTO avg_sal FROM employees;
    END WHILE;
    SET num = while_count;
END //
DELIMITER ;

```

### 5) 循环结构之REPEAT

REPEAT语句创建一个带条件判断的循环过程。与WHILE循环不同的是，REPEAT 循环首先会执行一次循环，然后在 UNTIL 中进行表达式的判断，如果满足条件就退出，即 END REPEAT；如果条件不满足，则会就继续执行循环，直到满足退出条件为止。

REPEAT语句的基本格式如下：

```
[repeat_label:] REPEAT
循环体的语句
UNTIL 结束循环的条件表达式
END REPEAT [repeat_label]

```

repeat_label为REPEAT语句的标注名称，该参数可以省略；REPEAT语句内的语句或语句群被重复，直至 expr_condition为真。

举例1：

```
DELIMITER //
CREATE PROCEDURE test_repeat()
BEGIN
    DECLARE i INT DEFAULT 0;
    REPEAT
    	SET i = i + 1;
    UNTIL i >= 10
    END REPEAT;
    SELECT i;
END //
DELIMITER ;

```

举例2：当市场环境变好时，公司为了奖励大家，决定给大家涨工资。声明存储过程 “update_salary_repeat()”，声明OUT参数num，输出循环次数。存储过程中实现循环给大家涨薪，薪资涨 为原来的1.15倍。直到全公司的平均薪资达到13000结束。并统计循环次数。

```
DELIMITER //
CREATE PROCEDURE update_salary_repeat(OUT num INT)
BEGIN
    DECLARE avg_sal DOUBLE ;
    DECLARE repeat_count INT DEFAULT 0;
    SELECT AVG(salary) INTO avg_sal FROM employees;
    REPEAT
    	UPDATE employees SET salary = salary * 1.15;
    	SET repeat_count = repeat_count + 1;
    	SELECT AVG(salary) INTO avg_sal FROM employees;
    UNTIL avg_sal >= 13000
    END REPEAT;
    SET num = repeat_count;
END //
DELIMITER ;

```

**对比三种循环结构：**

1. 这三种循环都可以省略名称，但如果循环中添加了循环控制语句（LEAVE或ITERATE）则必须添加名称。 

1. LOOP：一般用于实现简单的"死"循环 WHILE：先判断后执行 

1. REPEAT：先执行后判断，无条件至少执行一次

### 6) 跳转语句之LEAVE语句

LEAVE语句：可以用在循环语句内，或者以 BEGIN 和 END 包裹起来的程序体内，表示跳出循环或者跳出 程序体的操作。如果你有面向过程的编程语言的使用经验，你可以把 LEAVE 理解为 break。

基本格式如下：

```
LEAVE 标记名

```

其中，label参数表示循环的标志。LEAVE和BEGIN ... END或循环一起被使用。

举例1：创建存储过程 “leave_begin()”，声明INT类型的IN参数num。给BEGIN...END加标记名，并在 BEGIN...END中使用IF语句判断num参数的值。

如果num<=0，则使用LEAVE语句退出BEGIN...END； 如果num=1，则查询“employees”表的平均薪资； 如果num=2，则查询“employees”表的最低薪资； 如果num>2，则查询“employees”表的最高薪资。

IF语句结束后查询“employees”表的总人数。

```
DELIMITER //
CREATE PROCEDURE leave_begin(IN num INT)
    begin_label: BEGIN
        IF num<=0
        	THEN LEAVE begin_label;
        ELSEIF num=1
        	THEN SELECT AVG(salary) FROM employees;
        ELSEIF num=2
        	THEN SELECT MIN(salary) FROM employees;
        ELSE
        	SELECT MAX(salary) FROM employees;
        END IF;
        SELECT COUNT(*) FROM employees;
    END //
DELIMITER ;

```

举例2： 当市场环境不好时，公司为了渡过难关，决定暂时降低大家的薪资。声明存储过程“leave_while()”，声明 OUT参数num，输出循环次数，存储过程中使用WHILE循环给大家降低薪资为原来薪资的90%，直到全公司的平均薪资小于等于10000，并统计循环次数。

```
DELIMITER //
CREATE PROCEDURE leave_while(OUT num INT)
BEGIN
    DECLARE avg_sal DOUBLE;#记录平均工资
    DECLARE while_count INT DEFAULT 0; #记录循环次数
    SELECT AVG(salary) INTO avg_sal FROM employees; #① 初始化条件
    while_label:WHILE TRUE DO #② 循环条件
    #③ 循环体
    IF avg_sal <= 10000 THEN
    LEAVE while_label;
    END IF;
    UPDATE employees SET salary = salary * 0.9;
    SET while_count = while_count + 1;
    #④ 迭代条件
    SELECT AVG(salary) INTO avg_sal FROM employees;
    END WHILE;
    #赋值
    SET num = while_count;
END //
DELIMITER ;

```

### 7) 跳转语句之ITERATE语句

ITERATE语句：只能用在循环语句（LOOP、REPEAT和WHILE语句）内，表示重新开始循环，将执行顺序转到语句段开头处。如果你有面向过程的编程语言的使用经验，你可以把 ITERATE 理解为 continue，意思为“再次循环”。

语句基本格式如下：

```
ITERATE label

```

label参数表示循环的标志。ITERATE语句必须跟在循环标志前面。

举例： 定义局部变量num，初始值为0。循环结构中执行num + 1操作。

- 如果num < 10，则继续执行循环；

- 如果num > 15，则退出循环结构；

```
DELIMITER //
CREATE PROCEDURE test_iterate()
BEGIN
    DECLARE num INT DEFAULT 0;
    my_loop:LOOP
    	SET num = num + 1;
        IF num < 10
        	THEN ITERATE my_loop;
        ELSEIF num > 15
        	THEN LEAVE my_loop;
        END IF;
        SELECT 'MySQL';
    END LOOP my_loop;
END //
DELIMITER ;

```

## 4. 游标

### 1)  什么是游标（或光标）

虽然我们也可以通过筛选条件 WHERE 和 HAVING，或者是限定返回记录的关键字 LIMIT 返回一条记录， 但是，却无法在结果集中像指针一样，向前定位一条记录、向后定位一条记录，或者是随意定位到某一 条记录 ，并对记录的数据进行处理。

这个时候，就可以用到游标。游标，提供了一种灵活的操作方式，让我们能够对结果集中的每一条记录进行定位，并对指向的记录中的数据进行操作的数据结构。游标让 SQL 这种面向集合的语言有了面向过程开发的能力。

在 SQL 中，游标是一种临时的数据库对象，可以指向存储在数据库表中的数据行指针。这里游标 充当了 指针的作用 ，我们可以通过操作游标来对数据行进行操作。

MySQL中游标可以在存储过程和函数中使用。 

### 2) 使用游标步骤

游标必须在声明处理程序之前被声明，并且变量和条件还必须在声明游标或处理程序之前被声明。 

如果我们想要使用游标，一般需要经历四个步骤。不同的 DBMS 中，使用游标的语法可能略有不同。

**第一步，声明游标**

在MySQL中，使用DECLARE关键字来声明游标，其语法的基本形式如下：

```
DECLARE cursor_name CURSOR FOR select_statement;

```

这个语法适用于 MySQL，SQL Server，DB2 和 MariaDB。如果是用 Oracle 或者 PostgreSQL，需要写成：

```
DECLARE cursor_name CURSOR IS select_statement;

```

要使用 SELECT 语句来获取数据结果集，而此时还没有开始遍历数据，这里 select_statement 代表的是 SELECT 语句，返回一个用于创建游标的结果集。

比如：

```
DECLARE cur_emp CURSOR FOR
SELECT employee_id,salary FROM employees;

```

**第二步，打开游标**

打开游标的语法如下：

```
OPEN cursor_name

```

当我们定义好游标之后，如果想要使用游标，必须先打开游标。打开游标的时候 SELECT 语句的查询结果集就会送到游标工作区，为后面游标的 逐条读取 结果集中的记录做准备。

```
OPEN cur_emp;

```

**第三步，使用游标（从游标中取得数据）**

语法如下：

```
FETCH cursor_name INTO var_name [, var_name] ...

```

这句的作用是使用 cursor_name 这个游标来读取当前行，并且将数据保存到 var_name 这个变量中，游标指针指到下一行。如果游标读取的数据行有多个列名，则在 INTO 关键字后面赋值给多个变量名即可。

注意：var_name必须在声明游标之前就定义好。

```
FETCH cur_emp INTO emp_id, emp_sal ;

```

注意：

**第四步，关闭游标**

```
CLOSE cursor_name

```

有 OPEN 就会有 CLOSE，也就是打开和关闭游标。当我们使用完游标后需要关闭掉该游标。因为游标会 占用系统资源 ，如果不及时关闭，游标会一直保持到存储过程结束，影响系统运行的效率。而关闭游标 的操作，会释放游标占用的系统资源。

关闭游标之后，我们就不能再检索查询结果中的数据行，如果需要检索只能再次打开游标。

```
CLOSE cur_emp;

```

### 3) 举例

创建存储过程“get_count_by_limit_total_salary()”，声明IN参数 limit_total_salary，DOUBLE类型；声明 OUT参数total_count，INT类型。函数的功能可以实现累加薪资最高的几个员工的薪资值，直到薪资总和达到limit_total_salary参数的值，返回累加的人数给total_count。

```
DELIMITER //
CREATE PROCEDURE get_count_by_limit_total_salary(IN limit_total_salary DOUBLE, OUT total_count INT)
BEGIN
	DECLARE sum_salary DOUBLE DEFAULT 0; # 记录累加的总工资
	DECLARE cursor_salary DOUBLE DEFAULT 0; # 记录某一个工资值
	DECLARE emp_count INT DEFAULT 0; # 记录循环个数
	# 定义游标
	DECLARE emp_cursor CURSOR FOR SELECT salary FROM employees ORDER BY salary DESC;
	# 打开游标
	OPEN emp_cursor;
	
	REPEAT
		# 使用游标(从游标中获取数据)
		FETCH emp_cursor INTO cursor_salary;
		SET sum_salary = sum_salary + cursor_salary;
		SET emp_count = emp_count + 1;
		UNTIL sum_salary >= limit_total_salary
	END REPEAT;
	set total_count = emp_count;
	# 关闭游标
	CLOSE emp_cursor;
END //
DELIMITER;

```

### 4) 小结

游标是 MySQL 的一个重要的功能，为 逐条读取 结果集中的数据，提供了完美的解决方案。跟在应用层面实现相同的功能相比，游标可以在存储程序中使用，效率高，程序也更加简洁。 

但同时也会带来一些性能问题，比如在使用游标的过程中，会对数据行进行 加锁 ，这样在业务并发量大 的时候，不仅会影响业务之间的效率，还会 消耗系统资源 ，造成内存不足，这是因为游标是在内存中进行的处理。 

建议：养成用完之后就关闭的习惯，这样才能提高系统的整体效率。

## 补充：MySQL 8.0的新特性—全局变量的持久化

在MySQL数据库中，全局变量可以通过SET GLOBAL语句来设置。例如，设置服务器语句超时的限制，可 以通过设置系统变量max_execution_time来实现：

```
SET GLOBAL MAX_EXECUTION_TIME=2000;

```

使用SET GLOBAL语句设置的变量值只会 临时生效 。 数据库重启 后，服务器又会从MySQL配置文件中读取 变量的默认值。 MySQL 8.0版本新增了 SET PERSIST 命令。例如，设置服务器的最大连接数为1000：

```
SET PERSIST global max_connections = 1000;

```

MySQL会将该命令的配置保存到数据目录下的 mysqld-auto.cnf 文件中，下次启动时会读取该文件，用其中的配置来覆盖默认的配置文件。

# 第17章_触发器

在实际开发中，我们经常会遇到这样的情况：有 2 个或者多个相互关联的表，如 商品信息 和 库存信息 分 别存放在 2 个不同的数据表中，我们在添加一条新商品记录的时候，为了保证数据的完整性，必须同时 在库存表中添加一条库存记录。 

这样一来，我们就必须把这两个关联的操作步骤写到程序里面，而且要用 事务 包裹起来，确保这两个操 作成为一个 原子操作 ，要么全部执行，要么全部不执行。要是遇到特殊情况，可能还需要对数据进行手动维护，这样就很 容易忘记其中的一步 ，导致数据缺失。 

这个时候，咱们可以使用触发器。你可以创建一个触发器，让商品信息数据的插入操作自动触发库存数据的插入操作。这样一来，就不用担心因为忘记添加库存数据而导致的数据缺失了。

## 1. 触发器概述

触发器是由 事件来触发 某个操作，这些事件包括 INSERT 、 UPDATE 、 DELETE 事件。所谓事件就是指用户的动作或者触发某项行为。如果定义了触发程序，当数据库执行这些语句时候，就相当于事件发生 了，就会 自动 激发触发器执行相应的操作。

当对数据表中的数据执行插入、更新和删除操作，需要自动执行一些数据库逻辑时，可以使用触发器来实现。

## 2. 触发器的创建

### 1) 语法

```
CREATE TRIGGER 触发器名称
{BEFORE|AFTER} {INSERT|UPDATE|DELETE} ON 表名
FOR EACH ROW
触发器执行的语句块

```

说明：

- 表名 ：表示触发器监控的对象。 

- BEFORE|AFTER ：表示触发的时间。BEFORE 表示在事件之前触发；AFTER 表示在事件之后触发。 

- INSERT|UPDATE|DELETE ：表示触发的事件。

- INSERT 表示插入记录时触发； 

- UPDATE 表示更新记录时触发； 

- DELETE 表示删除记录时触发。

- 触发器执行的语句块 ：可以是单条SQL语句，也可以是由BEGIN…END结构组成的复合语句块。

### 2) 代码举例

**举例1：**

1. 创建数据表：

```
CREATE TABLE test_trigger (
id INT PRIMARY KEY AUTO_INCREMENT,
t_note VARCHAR(30)
);

CREATE TABLE test_trigger_log (
id INT PRIMARY KEY AUTO_INCREMENT,
t_log VARCHAR(30)
);

```

1. 创建触发器：创建名称为before_insert的触发器，向test_trigger数据表插入数据之前，向 test_trigger_log数据表中插入before_insert的日志信息。

```
DELIMITER //
CREATE TRIGGER before_insert
BEFORE INSERT ON test_trigger
FOR EACH ROW
BEGIN
    INSERT INTO test_trigger_log (t_log)
    VALUES('before_insert');
END //
DELIMITER ;

```

1. 向test_trigger数据表中插入数据

```
INSERT INTO test_trigger (t_note) VALUES ('测试 BEFORE INSERT 触发器');

```

1. 查看test_trigger_log数据表中的数据

```
mysql> SELECT * FROM test_trigger_log;
+----+---------------+
| id | t_log |
+----+---------------+
| 1 | before_insert |
+----+---------------+
1 row in set (0.00 sec)

```

**举例2：**

定义触发器“salary_check_trigger”，基于员工表“employees”的INSERT事件，在INSERT之前检查 将要添加的新员工薪资是否大于他领导的薪资，如果大于领导薪资，则报sqlstate_value为'HY000'的错 误，从而使得添加失败。

```
DELIMITER //
CREATE TRIGGER salary_check_trigger
BEFORE INSERT ON employees FOR EACH ROW
BEGIN
    DECLARE mgrsalary DOUBLE;
    SELECT salary INTO mgrsalary FROM employees WHERE employee_id = NEW.manager_id;
    IF NEW.salary > mgrsalary THEN
    	SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '薪资高于领导薪资错误';
    END IF;
END //
DELIMITER ;

```

上面触发器声明过程中的NEW关键字代表INSERT添加语句的新记录。

## 3. 查看、删除触发器

### 1)  查看触发器

查看触发器是查看数据库中已经存在的触发器的定义、状态和语法信息等。

方式1：查看当前数据库的所有触发器的定义

```
SHOW TRIGGERS\G

```

方式2：查看当前数据库中某个触发器的定义

```
SHOW CREATE TRIGGER 触发器名

```

方式3：从系统库information_schema的TRIGGERS表中查询“salary_check_trigger”触发器的信息。

```
SELECT * FROM information_schema.TRIGGERS;

```

### 2) 删除触发器

触发器也是数据库对象，删除触发器也用DROP语句，语法格式如下：

```
DROP TRIGGER IF EXISTS 触发器名称;

```

## 4. 触发器的优缺点

### 1) 优点

**1、触发器可以确保数据的完整性。**

假设我们用 进货单头表 （demo.importhead）来保存进货单的总体信息，包括进货单编号、供货商编号、仓库编号、总计进货数量、总计进货金额和验收日期。

| listnumber                  (进货单编号) | supplierid                 (进货商编号) | stockid             (参库编号) | quantity            (总计数量) | importvalue           (总计金额) | confirmationdate        （验收日期) | 
| -- | -- | -- | -- | -- | -- |
|   |   |   |   |   |   | 


用进货单明细表 （demo.importdetails）来保存进货商品的明细，包括进货单编号、商品编号、进货数 量、进货价格和进货金额。

| listnumber                          (进货单编号) | itemnumber                      (商品编号) | quantity                     (进货数量) | importprice                     (进货价格) | importvalue                   （进货金额) | 
| -- | -- | -- | -- | -- |
|   |   |   |   |   | 


每当我们录入、删除和修改一条进货单明细数据的时候，进货单明细表里的数据就会发生变动。这个时候，在进货单头表中的总计数量和总计金额就必须重新计算，否则，进货单头表中的总计数量和总计金 额就不等于进货单明细表中数量合计和金额合计了，这就是数据不一致。

为了解决这个问题，我们就可以使用触发器，规定每当进货单明细表有数据插入、修改和删除的操作 时，自动触发 2 步操作：

1）重新计算进货单明细表中的数量合计和金额合计；

2）用第一步中计算出来的值更新进货单头表中的合计数量与合计金额。

这样一来，进货单头表中的合计数量与合计金额的值，就始终与进货单明细表中计算出来的合计数量与 合计金额的值相同，数据就是一致的，不会互相矛盾。

**2、触发器可以帮助我们记录操作日志。**

利用触发器，可以具体记录什么时间发生了什么。比如，记录修改会员储值金额的触发器，就是一个很好的例子。这对我们还原操作执行时的具体场景，更好地定位问题原因很有帮助。

**3、触发器还可以用在操作数据前，对数据进行合法性检查。**

比如，超市进货的时候，需要库管录入进货价格。但是，人为操作很容易犯错误，比如说在录入数量的时候，把条形码扫进去了；录入金额的时候，看串了行，录入的价格远超售价，导致账面上的巨亏…… 这些都可以通过触发器，在实际插入或者更新操作之前，对相应的数据进行检查，及时提示错误，防止错误数据进入系统。

### 2) 缺点

**1、触发器最大的一个问题就是可读性差。**

因为触发器存储在数据库中，并且由事件驱动，这就意味着触发器有可能不受应用层的控制 。这对系统维护是非常有挑战的。

**2、相关数据的变更，可能会导致触发器出错。**

特别是数据表结构的变更，都可能会导致触发器出错，进而影响数据操作的正常运行。这些都会由于触发器本身的隐蔽性，影响到应用中错误原因排查的效率。

### 3) 注意点

注意，如果在子表中定义了外键约束，并且外键指定了ON UPDATE/DELETE CASCADE/SET NULL子句，此时修改父表被引用的键值或删除父表被引用的记录行时，也会引起子表的修改和删除操作，此时基于子表的UPDATE和DELETE语句定义的触发器并不会被激活。

例如：基于子表员工表（t_employee）的DELETE语句定义了触发器t1，而子表的部门编号（did）字段定义了外键约束引用了父表部门表（t_department）的主键列部门编号（did），并且该外键加了“ON DELETE SET NULL”子句，那么如果此时删除父表部门表（t_department）在子表员工表（t_employee） 有匹配记录的部门记录时，会引起子表员工表（t_employee）匹配记录的部门编号（did）修改为NULL， mysql> update demo.membermaster set memberdeposit=20 where memberid = 2; ERROR 1054 (42S22): Unknown column 'aa' in 'field list' 但是此时不会激活触发器t1。只有直接对子表员工表（t_employee）执行DELETE语句时才会激活触发器 t1。

# 第18章_MySQL8其他新特性

## 1. MySQL8新特性概述

MySQL从5.7版本直接跳跃发布了8.0版本 ，可见这是一个令人兴奋的里程碑版本。MySQL 8版本在功能上做了显著的改进与增强，开发者对MySQL的源代码进行了重构，最突出的一点是多MySQL Optimizer优化器进行了改进。不仅在速度上得到了改善，还为用户带来了更好的性能和更棒的体验。

### 1) MySQL8.0 新增特性

1. 更简便的NoSQL支持 NoSQL泛指非关系型数据库和数据存储。随着互联网平台的规模飞速发展，传统 的关系型数据库已经越来越不能满足需求。从5.6版本开始，MySQL就开始支持简单的NoSQL存储功能。 MySQL 8对这一功能做了优化，以更灵活的方式实现NoSQL功能，不再依赖模式（schema）。 

1. 更好的索引 在查询中，正确地使用索引可以提高查询的效率。MySQL 8中新增了 隐藏索引 和 降序索 引 。隐藏索引可以用来测试去掉索引对查询性能的影响。在查询中混合存在多列索引时，使用降序索引 可以提高查询的性能。 

1. 更完善的JSON支持 MySQL从5.7开始支持原生JSON数据的存储，MySQL 8对这一功能做了优化，增加 了聚合函数 JSON_ARRAYAGG() 和 JSON_OBJECTAGG() ，将参数聚合为JSON数组或对象，新增了行内 操作符 ->>，是列路径运算符 ->的增强，对JSON排序做了提升，并优化了JSON的更新操作。 

1. 安全和账户管理 MySQL 8中新增了 caching_sha2_password 授权插件、角色、密码历史记录和FIPS 模式支持，这些特性提高了数据库的安全性和性能，使数据库管理员能够更灵活地进行账户管理工作。 

1. InnoDB的变化 InnoDB是MySQL默认的存储引擎 ，是事务型数据库的首选引擎，支持事务安全表 （ACID），支持行锁定和外键。在MySQL 8 版本中，InnoDB在自增、索引、加密、死锁、共享锁等方面 做了大量的 改进和优化 ，并且支持原子数据定义语言（DDL），提高了数据安全性，对事务提供更好的 支持。

1. 数据字典 在之前的MySQL版本中，字典数据都存储在元数据文件和非事务表中。从MySQL 8开始新增 了事务数据字典，在这个字典里存储着数据库对象信息，这些数据字典存储在内部事务表中。 

1. 原子数据定义语句 MySQL 8开始支持原子数据定义语句（Automic DDL），即 原子DDL 。目前，只有 InnoDB存储引擎支持原子DDL。原子数据定义语句（DDL）将与DDL操作相关的数据字典更新、存储引擎 操作、二进制日志写入结合到一个单独的原子事务中，这使得即使服务器崩溃，事务也会提交或回滚。 使用支持原子操作的存储引擎所创建的表，在执行DROP TABLE、CREATE TABLE、ALTER TABLE、 RENAME TABLE、TRUNCATE TABLE、CREATE TABLESPACE、DROP TABLESPACE等操作时，都支持原子操 作，即事务要么完全操作成功，要么失败后回滚，不再进行部分提交。 对于从MySQL 5.7复制到MySQL 8 版本中的语句，可以添加 IF EXISTS 或 IF NOT EXISTS 语句来避免发生错误。 

1. 资源管理 MySQL 8开始支持创建和管理资源组，允许将服务器内运行的线程分配给特定的分组，以便 线程根据组内可用资源执行。组属性能够控制组内资源，启用或限制组内资源消耗。数据库管理员能够 根据不同的工作负载适当地更改这些属性。 目前，CPU时间是可控资源，由“虚拟CPU”这个概念来表 示，此术语包含CPU的核心数，超线程，硬件线程等等。服务器在启动时确定可用的虚拟CPU数量。拥有 对应权限的数据库管理员可以将这些CPU与资源组关联，并为资源组分配线程。 资源组组件为MySQL中的资源组管理提供了SQL接口。资源组的属性用于定义资源组。MySQL中存在两个默认组，系统组和用户 组，默认的组不能被删除，其属性也不能被更改。对于用户自定义的组，资源组创建时可初始化所有的 属性，除去名字和类型，其他属性都可在创建之后进行更改。 在一些平台下，或进行了某些MySQL的配 置时，资源管理的功能将受到限制，甚至不可用。例如，如果安装了线程池插件，或者使用的是macOS 系统，资源管理将处于不可用状态。在FreeBSD和Solaris系统中，资源线程优先级将失效。在Linux系统 中，只有配置了CAP_SYS_NICE属性，资源管理优先级才能发挥作用。

1. 字符集支持 MySQL 8中默认的字符集由 latin1 更改为 utf8mb4 ，并首次增加了日语所特定使用的集 合，utf8mb4_ja_0900_as_cs。 

1. 优化器增强 MySQL优化器开始支持隐藏索引和降序索引。隐藏索引不会被优化器使用，验证索引的必 要性时不需要删除索引，先将索引隐藏，如果优化器性能无影响就可以真正地删除索引。降序索引允许 优化器对多个列进行排序，并且允许排序顺序不一致。 

1. 公用表表达式 公用表表达式（Common Table Expressions）简称为CTE，MySQL现在支持递归和非递 归两种形式的CTE。CTE通过在SELECT语句或其他特定语句前 使用WITH语句对临时结果集 进行命名。

基础语法如下：

```
WITH cte_name (col_name1,col_name2 ...) AS (Subquery)
SELECT * FROM cte_name;

```

		Subquery代表子查询，子查询前使用WITH语句将结果集命名为cte_name，在后续的查询中即可使用 cte_name进行查询。

1. 窗口函数 MySQL 8开始支持窗口函数。在之前的版本中已存在的大部分 聚合函数 在MySQL 8中也可以 作为窗口函数来使用。

![](file://E:/%E9%9C%80%E5%90%8C%E6%AD%A5/%E6%88%91%E7%9A%84%E5%9D%9A%E6%9E%9C%E4%BA%91/mysql/MySQL%E5%9F%BA%E7%A1%80%E7%AF%87.assets/image-20220613202507072.png?lastModify=1710939852)

1. 正则表达式支持 MySQL在8.0.4以后的版本中采用支持Unicode的国际化组件库实现正则表达式操作， 这种方式不仅能提供完全的Unicode支持，而且是多字节安全编码。MySQL增加了REGEXP_LIKE()、 EGEXP_INSTR()、REGEXP_REPLACE()和 REGEXP_SUBSTR()等函数来提升性能。另外，regexp_stack_limit和 regexp_time_limit 系统变量能够通过匹配引擎来控制资源消耗。

1. 内部临时表 TempTable存储引擎取代MEMORY存储引擎成为内部临时表的默认存储引擎 。TempTable存储 引擎为VARCHAR和VARBINARY列提供高效存储。internal_tmp_mem_storage_engine会话变量定义了内部 临时表的存储引擎，可选的值有两个，TempTable和MEMORY，其中TempTable为默认的存储引擎。 temptable_max_ram系统配置项定义了TempTable存储引擎可使用的最大内存数量。

1. 日志记录 在MySQL 8中错误日志子系统由一系列MySQL组件构成。这些组件的构成由系统变量 log_error_services来配置，能够实现日志事件的过滤和写入。 WITH cte_name (col_name1,col_name2 ...) AS (Subquery) SELECT * FROM cte_name; 

1. 备份锁 新的备份锁允许在线备份期间执行数据操作语句，同时阻止可能造成快照不一致的操作。新 备份锁由 LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE 语法提供支持，执行这些操作需要备份管理 员特权。 

1. 增强的MySQL复制 MySQL 8复制支持对 JSON文档 进行部分更新的 二进制日志记录 ，该记录 使用紧凑 的二进制格式 ，从而节省记录完整JSON文档的空间。当使用基于语句的日志记录时，这种紧凑的日志记 录会自动完成，并且可以通过将新的binlog_row_value_options系统变量值设置为PARTIAL_JSON来启用。

### 2) MySQL8.0 移除的旧特性

在MySQL 5.7版本上开发的应用程序如果使用了MySQL8.0 移除的特性，语句可能会失败，或者产生不同 的执行结果。为了避免这些问题，对于使用了移除特性的应用，应当尽力修正避免使用这些特性，并尽 可能使用替代方法。

1. 查询缓存 查询缓存已被移除 ，删除的项有： （1）语句：FLUSH QUERY CACHE和RESET QUERY CACHE。 （2）系统变量：query_cache_limit、query_cache_min_res_unit、query_cache_size、 query_cache_type、query_cache_wlock_invalidate。 （3）状态变量：Qcache_free_blocks、 Qcache_free_memory、Qcache_hits、Qcache_inserts、Qcache_lowmem_prunes、Qcache_not_cached、 Qcache_queries_in_cache、Qcache_total_blocks。 （4）线程状态：checking privileges on cached query、checking query cache for query、invalidating query cache entries、sending cached result to client、storing result in query cache、waiting for query cache lock。

1. 加密相关 删除的加密相关的内容有：ENCODE()、DECODE()、ENCRYPT()、DES_ENCRYPT()和 DES_DECRYPT()函数，配置项des-key-file，系统变量have_crypt，FLUSH语句的DES_KEY_FILE选项， HAVE_CRYPT CMake选项。 对于移除的ENCRYPT()函数，考虑使用SHA2()替代，对于其他移除的函数，使 用AES_ENCRYPT()和AES_DECRYPT()替代。 

1. 空间函数相关 在MySQL 5.7版本中，多个空间函数已被标记为过时。这些过时函数在MySQL 8中都已被 移除，只保留了对应的ST_和MBR函数。 

1. \N和NULL 在SQL语句中，解析器不再将\N视为NULL，所以在SQL语句中应使用NULL代替\N。这项变化 不会影响使用LOAD DATA INFILE或者SELECT...INTO OUTFILE操作文件的导入和导出。在这类操作中，NULL 仍等同于\N。 

1. mysql_install_db 在MySQL分布中，已移除了mysql_install_db程序，数据字典初始化需要调用带着-- initialize或者--initialize-insecure选项的mysqld来代替实现。另外，--bootstrap和INSTALL_SCRIPTDIR CMake也已被删除。 

1. 通用分区处理程序 通用分区处理程序已从MySQL服务中被移除。为了实现给定表分区，表所使用的存 储引擎需要自有的分区处理程序。 提供本地分区支持的MySQL存储引擎有两个，即InnoDB和NDB，而在 MySQL 8中只支持InnoDB。 

1. 系统和状态变量信息 在INFORMATION_SCHEMA数据库中，对系统和状态变量信息不再进行维护。 GLOBAL_VARIABLES、SESSION_VARIABLES、GLOBAL_STATUS、SESSION_STATUS表都已被删除。另外，系 统变量show_compatibility_56也已被删除。被删除的状态变量有Slave_heartbeat_period、 Slave_last_heartbeat,Slave_received_heartbeats、Slave_retried_transactions、Slave_running。以上被删除 的内容都可使用性能模式中对应的内容进行替代。 

1. mysql_plugin工具 mysql_plugin工具用来配置MySQL服务器插件，现已被删除，可使用--plugin-load或- -plugin-load-add选项在服务器启动时加载插件或者在运行时使用INSTALL PLUGIN语句加载插件来替代该 工具。

## 2. 新特性1：窗口函数

### 1) 使用窗口函数前后对比

假设我现在有这样一个数据表，它显示了某购物网站在每个城市每个区的销售额：

```
CREATE TABLE sales(
id INT PRIMARY KEY AUTO_INCREMENT,
city VARCHAR(15),
county VARCHAR(15),
sales_value DECIMAL
);
INSERT INTO sales(city,county,sales_value)
VALUES
('北京','海淀',10.00),
('北京','朝阳',20.00),
('上海','黄埔',30.00),
('上海','长宁',10.00);

```

查询：

```
mysql> SELECT * FROM sales;
+----+------+--------+-------------+
| id | city | county | sales_value |
+----+------+--------+-------------+
| 1  | 北京  |  海淀   |      10    |
| 2  | 北京  |  朝阳   |      20    |
| 3  | 上海  |  黄埔   |      30    |
| 4  | 上海  |  长宁   |      10    |
+----+------+--------+-------------+
4 rows in set (0.00 sec)

```

需求：现在计算这个网站在每个城市的销售总额、在全国的销售总额、每个区的销售额占所在城市销售额中的比率，以及占总销售额中的比率。

如果用分组和聚合函数，就需要分好几步来计算。

第一步，计算总销售金额，并存入临时表 a：

```
CREATE TEMPORARY TABLE a -- 创建临时表
SELECT SUM(sales_value) AS sales_value -- 计算总计金额
FROM sales;

```

查看一下临时表 a ：

```
mysql> SELECT * FROM a;
+-------------+
| sales_value |
+-------------+
| 70 |
+-------------+
1 row in set (0.00 sec)

```

第二步，计算每个城市的销售总额并存入临时表 b：

```
CREATE TEMPORARY TABLE b -- 创建临时表
SELECT city, SUM(sales_value) AS sales_value -- 计算城市销售合计
FROM sales
GROUP BY city;

```

查看临时表 b ：

```
mysql> SELECT * FROM b;
+------+-------------+
| city | sales_value |
+------+-------------+
| 北京  |     30      |
| 上海  |     40      |
+------+-------------+
2 rows in set (0.00 sec)

```

第三步，计算各区的销售占所在城市的总计金额的比例，和占全部销售总计金额的比例。我们可以通过下面的连接查询获得需要的结果：

```
mysql> SELECT s.city AS 城市,s.county AS 区,s.sales_value AS 区销售额,
-> b.sales_value AS 市销售额,s.sales_value/b.sales_value AS 市比率,
-> a.sales_value AS 总销售额,s.sales_value/a.sales_value AS 总比率
-> FROM sales s
-> JOIN b ON (s.city=b.city) -- 连接市统计结果临时表
-> JOIN a -- 连接总计金额临时表
-> ORDER BY s.city,s.county;
+------+------+----------+----------+--------+----------+--------+
| 城市 | 区 | 区销售额 | 市销售额 | 市比率 | 总销售额 | 总比率 |
+------+------+----------+----------+--------+----------+--------+
| 上海 | 长宁 | 10 | 40 | 0.2500 | 70 | 0.1429 |
| 上海 | 黄埔 | 30 | 40 | 0.7500 | 70 | 0.4286 |
| 北京 | 朝阳 | 20 | 30 | 0.6667 | 70 | 0.2857 |
| 北京 | 海淀 | 10 | 30 | 0.3333 | 70 | 0.1429 |
+------+------+----------+----------+--------+----------+--------+
4 rows in set (0.00 sec)

```

结果显示：市销售金额、市销售占比、总销售金额、总销售占比都计算出来了。

同样的查询，如果用窗口函数，就简单多了。我们可以用下面的代码来实现：

```
mysql> SELECT city AS 城市,county AS 区,sales_value AS 区销售额,
-> SUM(sales_value) OVER(PARTITION BY city) AS 市销售额, -- 计算市销售额
-> sales_value/SUM(sales_value) OVER(PARTITION BY city) AS 市比率,
-> SUM(sales_value) OVER() AS 总销售额, -- 计算总销售额
-> sales_value/SUM(sales_value) OVER() AS 总比率
-> FROM sales
-> ORDER BY city,county;
+------+------+----------+----------+--------+----------+--------+
| 城市 | 区 | 区销售额 | 市销售额 | 市比率 | 总销售额 | 总比率 |
+------+------+----------+----------+--------+----------+--------+
| 上海 | 长宁 | 10 | 40 | 0.2500 | 70 | 0.1429 |
| 上海 | 黄埔 | 30 | 40 | 0.7500 | 70 | 0.4286 |
| 北京 | 朝阳 | 20 | 30 | 0.6667 | 70 | 0.2857 |
| 北京 | 海淀 | 10 | 30 | 0.3333 | 70 | 0.1429 |
+------+------+----------+-----------+--------+----------+--------+
4 rows in set (0.00 sec)

```

结果显示，我们得到了与上面那种查询同样的结果。 

使用窗口函数，只用了一步就完成了查询。而且，由于没有用到临时表，执行的效率也更高了。很显 然，在这种需要用到分组统计的结果对每一条记录进行计算的场景下，使用窗口函数更好。

### 2) 窗口函数分类

MySQL从8.0版本开始支持窗口函数。窗口函数的作用类似于在查询中对数据进行分组，不同的是，分组操作会把分组的结果聚合成一条记录，而窗口函数是将结果置于每一条数据记录中。

窗口函数可以分为 静态窗口函数 和 动态窗口函数 。

- 静态窗口函数的窗口大小是固定的，不会因为记录的不同而不同；

- 动态窗口函数的窗口大小会随着记录的不同而变化。

MySQL官方网站窗口函数的网址为[https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptio](https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptio) ns.html#function_row-number。 

窗口函数总体上可以分为序号函数、分布函数、前后函数、首尾函数和其他函数，如下表：

![](file://E:/%E9%9C%80%E5%90%8C%E6%AD%A5/%E6%88%91%E7%9A%84%E5%9D%9A%E6%9E%9C%E4%BA%91/mysql/MySQL%E5%9F%BA%E7%A1%80%E7%AF%87.assets/image-20220613210116486.png?lastModify=1710939852)

### 3) 语法结构

窗口函数的语法结构是：

```
函数 OVER（[PARTITION BY 字段名 ORDER BY 字段名 ASC|DESC]）

```

或者是：

```
函数 OVER 窗口名 … WINDOW 窗口名 AS （[PARTITION BY 字段名 ORDER BY 字段名 ASC|DESC]）

```

- OVER 关键字指定函数窗口的范围。

- 如果省略后面括号中的内容，则窗口会包含满足WHERE条件的所有记录，窗口函数会基于所有满足WHERE条件的记录进行计算。

- 如果OVER关键字后面的括号不为空，则可以使用如下语法设置窗口。

- 窗口名：为窗口设置一个别名，用来标识窗口。

- PARTITION BY子句：指定窗口函数按照哪些字段进行分组。分组后，窗口函数可以在每个分组中分别执行。

- ORDER BY子句：指定窗口函数按照哪些字段进行排序。执行排序操作使窗口函数按照排序后的数据记录的顺序进行编号。

- FRAME子句：为分区中的某个子集定义规则，可以用来作为滑动窗口使用。

### 4) 分类讲解

创建表：

```
CREATE TABLE goods(
id INT PRIMARY KEY AUTO_INCREMENT,
category_id INT,
category VARCHAR(15),
NAME VARCHAR(30),
price DECIMAL(10,2),
stock INT,
upper_time DATETIME
);

```

添加数据：

```
INSERT INTO goods(category_id,category,NAME,price,stock,upper_time)
VALUES
(1, '女装/女士精品', 'T恤', 39.90, 1000, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '连衣裙', 79.90, 2500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '卫衣', 89.90, 1500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '牛仔裤', 89.90, 3500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '百褶裙', 29.90, 500, '2020-11-10 00:00:00'),
(1, '女装/女士精品', '呢绒外套', 399.90, 1200, '2020-11-10 00:00:00'),
(2, '户外运动', '自行车', 399.90, 1000, '2020-11-10 00:00:00'),
(2, '户外运动', '山地自行车', 1399.90, 2500, '2020-11-10 00:00:00'),
(2, '户外运动', '登山杖', 59.90, 1500, '2020-11-10 00:00:00'),
(2, '户外运动', '骑行装备', 399.90, 3500, '2020-11-10 00:00:00'),
(2, '户外运动', '运动外套', 799.90, 500, '2020-11-10 00:00:00'),
(2, '户外运动', '滑板', 499.90, 1200, '2020-11-10 00:00:00');

```

下面针对goods表中的数据来验证每个窗口函数的功能。

#### 1) 序号函数

**1. ROW_NUMBER()函数**

ROW_NUMBER()函数能够对数据中的序号进行顺序显示。

举例：查询 goods 数据表中每个商品分类下价格降序排列的各个商品信息。

```
mysql> SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS
row_num, id, category_id, category, NAME, price, stock
FROM goods;
+---------+----+-------------+---------------+------------+---------+-------+
| row_num | id | category_id |    category   |     NAME   |  price  | stock |
+---------+----+-------------+---------------+------------+---------+-------+
|    1    |  6 |     1       |  女装/女士精品  | 呢绒外套     | 399.90  | 1200  |
|    2    |  3 |     1       |  女装/女士精品  | 卫衣        | 89.90   | 1500  |
|    3    |  4 |     1       |  女装/女士精品  | 牛仔裤       | 89.90   | 3500  |
|    4    |  2 |     1       |  女装/女士精品  | 连衣裙       | 79.90   | 2500  |
|    5    |  1 |     1       |  女装/女士精品  | T恤         | 39.90   | 1000  |
|    6    |  5 |     1       |  女装/女士精品  | 百褶裙       | 29.90   | 500   |
|    1    |  8 |     2       |     户外运动   | 山地自行车    | 1399.90 | 2500  |
|    2    | 11 |     2       |     户外运动   | 运动外套      | 799.90  | 500  |
|    3    | 12 |     2       |     户外运动   | 滑板         | 499.90  | 1200  |
|    4    |  7 |     2       |     户外运动   | 自行车       | 399.90  | 1000  |
|    5    | 10 |     2       |     户外运动   | 骑行装备     | 399.90  | 3500  |
|    6    |  9 |     2       |     户外运动   | 登山杖       | 59.90   | 1500  |
+---------+----+-------------+---------------+------------+---------+-------+
12 rows in set (0.00 sec)

```

举例：查询 goods 数据表中每个商品分类下价格最高的3种商品信息。

```
mysql> SELECT *
-> FROM (
-> SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS
row_num,
-> id, category_id, category, NAME, price, stock
-> FROM goods) t
-> WHERE row_num <= 3;
+---------+----+-------------+---------------+------------+---------+-------+
| row_num | id | category_id |     category  |      NAME  |  price  | stock |
+---------+----+-------------+---------------+------------+---------+-------+
|     1   |  6 |      1      | 女装/女士精品   | 呢绒外套     | 399.90  | 1200  |
|     2   |  3 |      1      | 女装/女士精品   | 卫衣        | 89.90   | 1500  |
|     3   |  4 |      1      | 女装/女士精品   | 牛仔裤      | 89.90    | 3500 |
|     1   |  8 |      2      | 户外运动       | 山地自行车   | 1399.90  | 2500 |
|     2   | 11 |      2      | 户外运动       | 运动外套     | 799.90  | 500   |
|     3   | 12 |      2      | 户外运动       | 滑板        | 499.90   | 1200 |
+---------+----+-------------+---------------+------------+----------+-------+
6 rows in set (0.00 sec)

```

在名称为“女装/女士精品”的商品类别中，有两款商品的价格为89.90元，分别是卫衣和牛仔裤。两款商品 的序号都应该为2，而不是一个为2，另一个为3。此时，可以使用RANK()函数和DENSE_RANK()函数解 决。

**2．RANK()函数**

使用RANK()函数能够对序号进行并列排序，并且会跳过重复的序号，比如序号为1、1、3。 

举例：使用RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。

```
mysql> SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
-> id, category_id, category, NAME, price, stock
-> FROM goods;
+---------+----+-------------+---------------+------------+---------+-------+
| row_num | id | category_id | category      | NAME       | price   | stock |
+---------+----+-------------+---------------+------------+---------+-------+
|     1   | 6  |     1       | 女装/女士精品   | 呢绒外套     | 399.90  | 1200  |
|     2   | 3  |     1       | 女装/女士精品   | 卫衣        | 89.90   | 1500  |
|     2   | 4  |     1       | 女装/女士精品   | 牛仔裤      | 89.90   | 3500   |
|     4   | 2  |     1       | 女装/女士精品   | 连衣裙      | 79.90   | 2500   |
|     5   | 1  |     1       | 女装/女士精品   | T恤        | 39.90   | 1000   |
|     6   | 5  |     1       | 女装/女士精品   | 百褶裙      | 29.90   | 500    |
|     1   | 8  |     2       | 户外运动       | 山地自行车   | 1399.90 | 2500   |
|     2   | 11 |     2       | 户外运动       | 运动外套     | 799.90  | 500   |
|     3   | 12 |     2       | 户外运动       | 滑板        | 499.90  | 1200   |
|     4   | 7  |     2       | 户外运动       | 自行车      | 399.90   | 1000  |
|     4   | 10 |     2       | 户外运动       | 骑行装备    | 399.90   | 3500  |
|     6   | 9  |     2       | 户外运动       | 登山杖      | 59.90   | 1500   |
+---------+----+-------------+---------------+------------+---------+-------+
12 rows in set (0.00 sec)

```

**3．DENSE_RANK()函数**

DENSE_RANK()函数对序号进行并列排序，并且不会跳过重复的序号，比如序号为1、1、2。 举例：使用DENSE_RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。

```
mysql> SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS
row_num,
-> id, category_id, category, NAME, price, stock
-> FROM goods;
+---------+----+-------------+---------------+------------+---------+-------+
| row_num | id | category_id | category      | NAME       | price   | stock |
+---------+----+-------------+---------------+------------+---------+-------+
|    1    | 6  |      1      | 女装/女士精品   |     呢绒外套 | 399.90 | 1200   |
|    2    | 3  |      1      | 女装/女士精品   |     卫衣    | 89.90  | 1500   |
|    2    | 4  |      1      | 女装/女士精品   |     牛仔裤  | 89.90   | 3500  |
|    3    | 2  |      1      | 女装/女士精品   |     连衣裙  | 79.90   | 2500  |
|    4    | 1  |      1      | 女装/女士精品   |     T恤    | 39.90   | 1000  |
|    5    | 5  |      1      | 女装/女士精品   |     百褶裙  | 29.90   | 500   |
|    1    | 8  |      2      | 户外运动       |    山地自行车| 1399.90 | 2500 |
|    2    | 11 |      2      | 户外运动       |    运动外套  | 799.90 | 500    |
|    3    | 12 |      2      | 户外运动       |    滑板     | 499.90 | 1200   |
|    4    | 7  |      2      | 户外运动       |    自行车    | 399.90 | 1000   |
|    4    | 10 |      2      | 户外运动       |    骑行装备  | 399.90 | 3500   |
|    5    | 9  |      2      | 户外运动       |    登山杖    | 59.90 | 1500   |
+---------+----+-------------+---------------+------------+---------+-------+
12 rows in set (0.00 sec)

```

#### 2) 分布函数

**1．PERCENT_RANK()函数**

PERCENT_RANK()函数是等级值百分比函数。按照如下方式进行计算。

```
(rank - 1) / (rows - 1)

```

其中，rank的值为使用RANK()函数产生的序号，rows的值为当前窗口的总记录数。

举例：计算 goods 数据表中名称为“女装/女士精品”的类别下的商品的PERCENT_RANK值。

```
#写法一：
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS r,
PERCENT_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS pr,
id, category_id, category, NAME, price, stock
FROM goods
WHERE category_id = 1;
#写法二：
mysql> SELECT RANK() OVER w AS r,
-> PERCENT_RANK() OVER w AS pr,
-> id, category_id, category, NAME, price, stock
-> FROM goods
-> WHERE category_id = 1 WINDOW w AS (PARTITION BY category_id ORDER BY price
DESC);
+---+-----+----+-------------+---------------+----------+--------+-------+
| r | pr  | id | category_id | category      | NAME     | price  | stock |
+---+-----+----+-------------+---------------+----------+--------+-------+
| 1 | 0   | 6  |          1  | 女装/女士精品   |   呢绒外套 | 399.90 | 1200 |
| 2 | 0.2 | 3  |          1  | 女装/女士精品   |   卫衣    | 89.90 | 1500 |
| 2 | 0.2 | 4  |          1  | 女装/女士精品   |   牛仔裤  | 89.90 | 3500 |
| 4 | 0.6 | 2  |          1  | 女装/女士精品   |   连衣裙  | 79.90 | 2500 |
| 5 | 0.8 | 1  |          1  | 女装/女士精品   |   T恤    | 39.90 | 1000 |
| 6 | 1   | 5  |          1  | 女装/女士精品   |   百褶裙  | 29.90 | 500 |
+---+-----+----+-------------+---------------+----------+--------+-------+
6 rows in set (0.00 sec)

```

**2．CUME_DIST()函数**

CUME_DIST()函数主要用于查询小于或等于某个值的比例。 

举例：查询goods数据表中小于或等于当前价格的比例。

```
mysql> SELECT CUME_DIST() OVER(PARTITION BY category_id ORDER BY price ASC) AS cd,
-> id, category, NAME, price
-> FROM goods;
+---------------------+----+---------------+------------+---------+
|                cd   | id | category      | NAME       | price   |
+---------------------+----+---------------+------------+---------+
| 0.16666666666666666 | 5  | 女装/女士精品   | 百褶裙      | 29.90 |
| 0.3333333333333333  | 1  | 女装/女士精品   | T恤        | 39.90 |
| 0.5                 | 2  | 女装/女士精品   | 连衣裙      | 79.90 |
| 0.8333333333333334  | 3  | 女装/女士精品   | 卫衣       | 89.90 |
| 0.8333333333333334  | 4  | 女装/女士精品   | 牛仔裤     | 89.90 |
| 1                   | 6  | 女装/女士精品   | 呢绒外套    | 399.90 |
| 0.16666666666666666 | 9  | 户外运动       | 登山杖      | 59.90 |
| 0.5                 | 7  | 户外运动       | 自行车      | 399.90 |
| 0.5                 | 10 | 户外运动       | 骑行装备     | 399.90 |
| 0.6666666666666666  | 12 | 户外运动       | 滑板        | 499.90 |
| 0.8333333333333334  | 11 | 户外运动       | 运动外套     | 799.90 |
| 1                   | 8  | 户外运动       | 山地自行车   | 1399.90 |
+---------------------+----+---------------+------------+---------+
12 rows in set (0.00 sec)

```

#### 3) 前后函数

**1．LAG(expr,n)函数**

LAG(expr,n)函数返回当前行的前n行的expr的值。 

举例：查询goods数据表中前一个商品价格与当前商品价格的差值。

```mysql
mysql> SELECT id, category, NAME, price, pre_price, price - pre_price AS diff_price
-> FROM (
-> SELECT id, category, NAME, price,LAG(price,1) OVER w AS pre_price
-> FROM goods
-> WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;
+----+---------------+------------+---------+-----------+------------+
| id | category | NAME | price | pre_price | diff_price |
+----+---------------+------------+---------+-----------+------------+
| 5 | 女装/女士精品 | 百褶裙 | 29.90 | NULL | NULL |
| 1 | 女装/女士精品 | T恤 | 39.90 | 29.90 | 10.00 |
| 2 | 女装/女士精品 | 连衣裙 | 79.90 | 39.90 | 40.00 |
| 3 | 女装/女士精品 | 卫衣 | 89.90 | 79.90 | 10.00 |
| 4 | 女装/女士精品 | 牛仔裤 | 89.90 | 89.90 | 0.00 |
| 6 | 女装/女士精品 | 呢绒外套 | 399.90 | 89.90 | 310.00 |
| 9 | 户外运动 | 登山杖 | 59.90 | NULL | NULL |
| 7 | 户外运动 | 自行车 | 399.90 | 59.90 | 340.00 |
| 10 | 户外运动 | 骑行装备 | 399.90 | 399.90 | 0.00 |
| 12 | 户外运动 | 滑板 | 499.90 | 399.90 | 100.00 |
| 11 | 户外运动 | 运动外套 | 799.90 | 499.90 | 300.00 |
| 8 | 户外运动 | 山地自行车 | 1399.90 | 799.90 | 600.00 |
+----+---------------+------------+---------+-----------+------------+
12 rows in set (0.00 sec)
```

**2．LEAD(expr,n)函数**

LEAD(expr,n)函数返回当前行的后n行的expr的值。 

举例：查询goods数据表中后一个商品价格与当前商品价格的差值。

```mysql
mysql> SELECT id, category, NAME, behind_price, price,behind_price - price AS
diff_price
-> FROM(
-> SELECT id, category, NAME, price,LEAD(price, 1) OVER w AS behind_price
-> FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price)) t;
+----+---------------+------------+--------------+---------+------------+
| id | category      | NAME       | behind_price | price   | diff_price |
+----+---------------+------------+--------------+---------+------------+
| 5  | 女装/女士精品   | 百褶裙       | 39.90       | 29.90 | 10.00 |
| 1  | 女装/女士精品   | T恤         | 79.90       | 39.90 | 40.00 |
| 2  | 女装/女士精品   | 连衣裙      | 89.90        | 79.90 | 10.00 |
| 3  | 女装/女士精品   | 卫衣        | 89.90       | 89.90 | 0.00 |
| 4  | 女装/女士精品   | 牛仔裤       | 399.90     | 89.90 | 310.00 |
| 6  | 女装/女士精品   | 呢绒外套     | NULL       | 399.90 | NULL |
| 9  | 户外运动       | 登山杖       | 399.90    | 59.90 | 340.00 |
| 7  | 户外运动       | 自行车       | 399.90    | 399.90 | 0.00 |
| 10 | 户外运动       | 骑行装备     | 499.90     | 399.90 | 100.00 |
| 12 | 户外运动       | 滑板         | 799.90    | 499.90 | 300.00 |
| 11 | 户外运动       | 运动外套     | 1399.90    | 799.90 | 600.00 |
| 8  | 户外运动       | 山地自行车   | NULL       | 1399.90 | NULL |
+----+---------------+------------+--------------+---------+------------+
12 rows in set (0.00 sec)
```

#### 4) 首尾函数

**1．FIRST_VALUE(expr)函数**

FIRST_VALUE(expr)函数返回第一个expr的值。

举例：按照价格排序，查询第1个商品的价格信息。

```mysql
mysql> SELECT id, category, NAME, price, stock,FIRST_VALUE(price) OVER w AS
first_price
-> FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);
+----+---------------+------------+---------+-------+-------------+
| id | category      | NAME | price | stock | first_price |
+----+---------------+------------+---------+-------+-------------+
| 5  | 女装/女士精品   | 百褶裙 | 29.90 | 500 | 29.90 |
| 1  | 女装/女士精品   | T恤 | 39.90 | 1000 | 29.90 |
| 2  | 女装/女士精品   | 连衣裙 | 79.90 | 2500 | 29.90 |
| 3  | 女装/女士精品   | 卫衣 | 89.90 | 1500 | 29.90 |
| 4  | 女装/女士精品   | 牛仔裤 | 89.90 | 3500 | 29.90 |
| 6  | 女装/女士精品   | 呢绒外套 | 399.90 | 1200 | 29.90 |
| 9  | 户外运动       | 登山杖 | 59.90 | 1500 | 59.90 |
| 7  | 户外运动       | 自行车 | 399.90 | 1000 | 59.90 |
| 10 | 户外运动       | 骑行装备 | 399.90 | 3500 | 59.90 |
| 12 | 户外运动       | 滑板 | 499.90 | 1200 | 59.90 |
| 11 | 户外运动       | 运动外套 | 799.90 | 500 | 59.90 |
| 8  | 户外运动       | 山地自行车 | 1399.90 | 2500 | 59.90 |
+----+---------------+------------+---------+-------+-------------+
12 rows in set (0.00 sec)
```

**LAST_VALUE(expr)函数**

LAST_VALUE(expr)函数返回最后一个expr的值。 

举例：按照价格排序，查询最后一个商品的价格信息。

```mysql
mysql> SELECT id, category, NAME, price, stock,LAST_VALUE(price) OVER w AS last_price
-> FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);
+----+---------------+------------+---------+-------+------------+
| id | category      | NAME | price | stock | last_price |
+----+---------------+------------+---------+-------+------------+
| 5  | 女装/女士精品   | 百褶裙 | 29.90 | 500 | 29.90 |
| 1  | 女装/女士精品   | T恤 | 39.90 | 1000 | 39.90 |
| 2  | 女装/女士精品   | 连衣裙 | 79.90 | 2500 | 79.90 |
| 3  | 女装/女士精品   | 卫衣 | 89.90 | 1500 | 89.90 |
| 4  | 女装/女士精品   | 牛仔裤 | 89.90 | 3500 | 89.90 |
| 6  | 女装/女士精品   | 呢绒外套 | 399.90 | 1200 | 399.90 |
| 9  | 户外运动       | 登山杖 | 59.90 | 1500 | 59.90 |
| 7  | 户外运动       | 自行车 | 399.90 | 1000 | 399.90 |
| 10 | 户外运动       | 骑行装备 | 399.90 | 3500 | 399.90 |
| 12 | 户外运动       | 滑板 | 499.90 | 1200 | 499.90 |
| 11 | 户外运动       | 运动外套 | 799.90 | 500 | 799.90 |
| 8  | 户外运动       | 山地自行车 | 1399.90 | 2500 | 1399.90 |
+----+---------------+------------+---------+-------+------------+
12 rows in set (0.00 sec)
```

#### 5) 其他函数

**1．NTH_VALUE(expr,n)函数**

NTH_VALUE(expr,n)函数返回第n个expr的值。 举例：查询goods数据表中排名第2和第3的价格信息。

```mysql
mysql> SELECT id, category, NAME, price,NTH_VALUE(price,2) OVER w AS second_price,
-> NTH_VALUE(price,3) OVER w AS third_price
-> FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);
+----+---------------+------------+---------+--------------+-------------+
| id | category      | NAME       | price   | second_price | third_price |
+----+---------------+------------+---------+--------------+-------------+
| 5  | 女装/女士精品   | 百褶裙 | 29.90 | NULL | NULL |
| 1  | 女装/女士精品   | T恤 | 39.90 | 39.90 | NULL |
| 2  | 女装/女士精品   | 连衣裙 | 79.90 | 39.90 | 79.90 |
| 3  | 女装/女士精品   | 卫衣 | 89.90 | 39.90 | 79.90 |
| 4  | 女装/女士精品   | 牛仔裤 | 89.90 | 39.90 | 79.90 |
| 6  | 女装/女士精品   | 呢绒外套 | 399.90 | 39.90 | 79.90 |
| 9  | 户外运动       | 登山杖 | 59.90 | NULL | NULL |
| 7  | 户外运动       | 自行车 | 399.90 | 399.90 | 399.90 |
| 10 | 户外运动       | 骑行装备 | 399.90 | 399.90 | 399.90 |
| 12 | 户外运动       | 滑板 | 499.90 | 399.90 | 399.90 |
| 11 | 户外运动       | 运动外套 | 799.90 | 399.90 | 399.90 |
| 8  | 户外运动       | 山地自行车 | 1399.90 | 399.90 | 399.90 |
+----+---------------+------------+---------+--------------+-------------+
12 rows in set (0.00 sec)
```

**2．NTILE(n)函数**

NTILE(n)函数将分区中的有序数据分为n个桶，记录桶编号。 

举例：将goods表中的商品按照价格分为3组。

```mysql
mysql> SELECT NTILE(3) OVER w AS nt,id, category, NAME, price
-> FROM goods WINDOW w AS (PARTITION BY category_id ORDER BY price);
+----+----+---------------+------------+---------+
| nt | id | category      | NAME       | price |
+----+----+---------------+------------+---------+
| 1  | 5  | 女装/女士精品   | 百褶裙 | 29.90 |
| 1  | 1  | 女装/女士精品   | T恤 | 39.90 |
| 2  | 2  | 女装/女士精品   | 连衣裙 | 79.90 |
| 2  | 3  | 女装/女士精品   | 卫衣 | 89.90 |
| 3  | 4  | 女装/女士精品   | 牛仔裤 | 89.90 |
| 3  | 6  | 女装/女士精品   | 呢绒外套 | 399.90 |
| 1  | 9  | 户外运动       | 登山杖 | 59.90 |
| 1  | 7  | 户外运动       | 自行车 | 399.90 |
| 2  | 10 | 户外运动       | 骑行装备 | 399.90 |
| 2  | 12 | 户外运动       | 滑板 | 499.90 |
| 3  | 11 | 户外运动       | 运动外套 | 799.90 |
| 3  | 8  | 户外运动       | 山地自行车 | 1399.90 |
+----+----+---------------+------------+---------+
12 rows in set (0.00 sec)
```

### 5) 小结

窗口函数的特点是可以分组，而且可以在分组内排序。另外，窗口函数不会因为分组而减少原表中的行 数，这对我们在原表数据的基础上进行统计和排序非常有用。

## 3. 新特性2：公用表表达式

公用表表达式（或通用表表达式）简称为CTE（Common Table Expressions）。CTE是一个命名的临时结 果集，作用范围是当前语句。CTE可以理解成一个可以复用的子查询，当然跟子查询还是有点区别的， CTE可以引用其他CTE，但子查询不能引用其他子查询。所以，可以考虑代替子查询。

依据语法结构和执行方式的不同，公用表表达式分为 普通公用表表达式 和 递归公用表表达式 2 种。

### 1) 普通公用表表达式

普通公用表表达式的语法结构是：

```mysql
WITH CTE名称
AS （子查询）
SELECT|DELETE|UPDATE 语句;
```

普通公用表表达式类似于子查询，不过，跟子查询不同的是，它可以被多次引用，而且可以被其他的普 通公用表表达式所引用。

举例：查询员工所在的部门的详细信息。

```mysql
mysql> SELECT * FROM departments
-> WHERE department_id IN (
-> SELECT DISTINCT department_id
-> FROM employees
-> );
+---------------+------------------+------------+-------------+
| department_id | department_name  | manager_id | location_id |
+---------------+------------------+------------+-------------+
|     10        | Administration   | 200        | 1700        |
|     20        | Marketing        | 201        | 1800        |
|     30        | Purchasing       | 114        | 1700        |
|     40        | Human Resources  | 203        | 2400        |
|     50        | Shipping         | 121        | 1500        |
|     60        | IT               | 103        | 1400        |
|     70        | Public Relations | 204        | 2700        |
|     80        | Sales            | 145        | 2500        |
|     90        | Executive        | 100        | 1700        |
|     100       | Finance          | 108        | 1700        |
|     110       | Accounting       | 205        | 1700        |
+---------------+------------------+------------+-------------+
11 rows in set (0.00 sec)
```

这个查询也可以用普通公用表表达式的方式完成：

```mysql
mysql> WITH emp_dept_id
-> AS (SELECT DISTINCT department_id FROM employees)
-> SELECT *
-> FROM departments d JOIN emp_dept_id e
-> ON d.department_id = e.department_id;
+---------------+------------------+------------+-------------+---------------+
| department_id | department_name  | manager_id | location_id | department_id |
+---------------+------------------+------------+-------------+---------------+
|      90       | Executive        | 100        | 1700        | 90            |
|      60       | IT               | 103        | 1400        | 60            |
|      100      | Finance          | 108        | 1700        | 100           |
|      30       | Purchasing       | 114        | 1700        | 30            |
|      50       | Shipping         | 121        | 1500        | 50            |
|      80       | Sales            | 145        | 2500        | 80            |
|      10       | Administration   | 200        | 1700        | 10            |
|      20       | Marketing        | 201        | 1800        | 20            |
|      40       | Human Resources  | 203        | 2400        | 40            |
|      70       | Public Relations | 204        | 2700        | 70            |
|      110      | Accounting       | 205        | 1700        | 110           |
+---------------+------------------+------------+-------------+---------------+
11 rows in set (0.00 sec)
```

例子说明，公用表表达式可以起到子查询的作用。以后如果遇到需要使用子查询的场景，你可以在查询 之前，先定义公用表表达式，然后在查询中用它来代替子查询。而且，跟子查询相比，公用表表达式有 一个优点，就是定义过公用表表达式之后的查询，可以像一个表一样多次引用公用表表达式，而子查询 则不能。

###  2)  递归公用表表达式

递归公用表表达式也是一种公用表表达式，只不过，除了普通公用表表达式的特点以外，它还有自己的特点，就是可以调用自己。它的语法结构是：

```mysql
WITH RECURSIVE
CTE名称 AS （子查询）
SELECT|DELETE|UPDATE 语句;
```

递归公用表表达式由 2 部分组成，分别是种子查询和递归查询，中间通过关键字 UNION [ALL]进行连接。 这里的种子查询，意思就是获得递归的初始值。这个查询只会运行一次，以创建初始数据集，之后递归 查询会一直执行，直到没有任何新的查询数据产生，递归返回。

案例：针对于我们常用的employees表，包含employee_id，last_name和manager_id三个字段。如果a是b 的管理者，那么，我们可以把b叫做a的下属，如果同时b又是c的管理者，那么c就是b的下属，是a的下下 属。

下面我们尝试用查询语句列出所有具有下下属身份的人员信息。

如果用我们之前学过的知识来解决，会比较复杂，至少要进行 4 次查询才能搞定：

- 第一步，先找出初代管理者，就是不以任何别人为管理者的人，把结果存入临时表； 
- 第二步，找出所有以初代管理者为管理者的人，得到一个下属集，把结果存入临时表； 
- 第三步，找出所有以下属为管理者的人，得到一个下下属集，把结果存入临时表。 
- 第四步，找出所有以下下属为管理者的人，得到一个结果集。

如果第四步的结果集为空，则计算结束，第三步的结果集就是我们需要的下下属集了，否则就必须继续 进行第四步，一直到结果集为空为止。比如上面的这个数据表，就需要到第五步，才能得到空结果集。 而且，最后还要进行第六步：把第三步和第四步的结果集合并，这样才能最终获得我们需要的结果集。

如果用递归公用表表达式，就非常简单了。我介绍下具体的思路。

- 用递归公用表表达式中的种子查询，找出初代管理者。字段 n 表示代次，初始值为 1，表示是第一 代管理者。
- 用递归公用表表达式中的递归查询，查出以这个递归公用表表达式中的人为管理者的人，并且代次 的值加 1。直到没有人以这个递归公用表表达式中的人为管理者了，递归返回。
- 在最后的查询中，选出所有代次大于等于 3 的人，他们肯定是第三代及以上代次的下属了，也就是 下下属了。这样就得到了我们需要的结果集。

这里看似也是 3 步，实际上是一个查询的 3 个部分，只需要执行一次就可以了。而且也不需要用临时表 保存中间结果，比刚刚的方法简单多了。

代码实现：

```mysql
WITH RECURSIVE cte
AS
(
SELECT employee_id,last_name,manager_id,1 AS n FROM employees WHERE employee_id = 100
-- 种子查询，找到第一代领导
UNION ALL
SELECT a.employee_id,a.last_name,a.manager_id,n+1 FROM employees AS a JOIN cte
ON (a.manager_id = cte.employee_id) -- 递归查询，找出以递归公用表表达式的人为领导的人
)
SELECT employee_id,last_name FROM cte WHERE n >= 3;
```

总之，递归公用表表达式对于查询一个有共同的根节点的树形结构数据，非常有用。它可以不受层级的 限制，轻松查出所有节点的数据。如果用其他的查询方式，就比较复杂了。

### 3) 小结

公用表表达式的作用是可以替代子查询，而且可以被多次引用。递归公用表表达式对查询有一个共同根 节点的树形结构数据非常高效，可以轻松搞定其他查询方式难以处理的查询。