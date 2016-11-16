title: Sqlite常用SQL语句
date: 2015-06-27 21:38:13
categories: DB
tags: [sqlite, SQL]
---
本篇介绍Sqlite常用SQL语句写法.

<!-- more -->

+ sqlite是很经典的微型数据库.使用非常方便.这里把常用操作整理一下,作个参考.
+ [参考: 这篇SQL很多其他指令](http://www.tutorialspoint.com/sqlite/sqlite_update_query.htm)

+ [create table](http://www.tutorialspoint.com/sqlite/sqlite_create_table.htm)

+ [SQLite Python Tutorial](http://www.tutorialspoint.com/sqlite/sqlite_python.htm)

+ SQL操作: 增,删,改,查.

## 1. CREATE Table
```sql
格式:
CREATE TABLE database_name.table_name(
   column1 datatype  PRIMARY KEY(one or more columns),
   column2 datatype,
   column3 datatype,
   .....
   columnN datatype,
);


示例:
sqlite>CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

```


## 2. DROP Table
```sql
格式:
DROP TABLE database_name.table_name;

示例:
sqlite>.tables                # 查看有哪些表
sqlite>DROP TABLE COMPANY;    # 删除表

```


## 3. INSERT Table

```sql
格式:
方式1:
INSERT INTO TABLE_NAME (column1, column2, column3,...columnN)]  
VALUES (value1, value2, value3,...valueN);

方式2:
INSERT INTO TABLE_NAME VALUES (value1,value2,value3,...valueN);

方式3:
INSERT INTO first_table_name [(column1, column2, ... columnN)] 
   SELECT column1, column2, ...columnN 
   FROM second_table_name
   [WHERE condition];
   
示例:
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Paul', 32, 'California', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Allen', 25, 'Texas', 15000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'Teddy', 23, 'Norway', 20000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'David', 27, 'Texas', 85000.00 );

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Kim', 22, 'South-Hall', 45000.00 );

```



## 4. UPDATE Table

```sql
格式:
UPDATE table_name
SET column1 = value1, column2 = value2...., columnN = valueN
WHERE [condition];


示例:
qlite> UPDATE COMPANY SET ADDRESS = 'Texas' WHERE ID = 6;
sqlite> UPDATE COMPANY SET ADDRESS = 'Texas', SALARY = 20000.00;
```


## 5. SELECT Table

```sql
格式:
方式1:
SELECT column1, column2, columnN FROM table_name;

方式2:
SELECT * FROM table_name;


示例:
sqlite> SELECT ID, NAME, SALARY FROM COMPANY;

```
