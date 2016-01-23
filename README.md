# SQLite

+ SQL（structured query language）：结构化查询语言
  
+ SQLite是一款轻型的__嵌入式关系数据库__
  
+ 主键的设计原则：
  
  + 主键应当是对用户没有意义的
  + 永远也不要更新主键
  + 主键可以由计算机自动更新增长
  + 主键不能为空
  
+ SQL语句种类
  
  + DDL (Data Definition Language)
    
    create和drop等操作，即创建表或删除表操作。
    
  + DML (Data Manipulation Language)
    
    insert, update, delete等操作，即增、删、改等操作。
    
  + DQL (Data Query Languate)
    
    select操作，即查询操作。常用到的关键字有：WHERE, ORDER BY, GROUP BY和HAVING等。
  
+ DDL语句
  
  + 创建表
    
    ``` sql
    CREATE TABLE IF NOT EXISTS 't_student' (
      'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      'name' TEXT,
      'age' INTEGER,
      'height' REAL
    );
    ```
    
    注意，主键是`不为空`，`标明主键`，`自动增长`。
    
  + 删除表
    
    ``` sql
    DROP TABLE IF EXISTS 't_student';
    ```
  
+ DML语句
  
  + 插入数据
    
    ``` sql
    INSERT INTO 't_student' (name, age, height) VALUES ('joyann', 12, 1,80);
    ```
    
  + 更新数据
    
    ``` sql
    UPDATE 't_student' SET name = 'A';
    
    UPDATE 't_student' SET name = 'B' WHERE age = 10;
    
    UPDATE 't_student' SET name = 'C' WHERE age < 20 and age > 10;
    ```
    
  + 删除数据
    
    ``` sql
    DELETE FROM 't_student';
    
    DELETE FROM 't_student' WHERE age < 20;
    ```
  
+ DQL语句
  
  + 基本查询
    
    ``` sql
    SELECT * FROM 't_student';
    ```
    
  + 查询某些字段
    
    ``` sql
    SELECT name, age FROM 't_student';
    ```
    
  + 条件查询
    
    ``` sql
    SELECT * FROM 't_student' WHERE age < 20;
    ```
    
  + like查询(名字中包含'a'的)
    
    ``` sql
    SELECT * FROM 't_student' WHERE name like '%a%';
    ```
    
  + 计算个数
    
    ``` sql
    -- 计算多少列 --
    SELECT COUNT(*) FROM 't_student';
    -- 计算某一列的个数 --
    SELECT COUNT(age) FROM 't_student';
    ```
    
  + 排序
    
    ``` sql
    -- 升序 --
    SELECT * FROM 't_student' ORDER BY age;
    -- 降序 --
    SELECT * FROM 't_student' ORDER BT age DESC;
    ```
    
  + 起别名
    
    ``` sql
    -- 给列起别名(AS可以省略) --
    SELECT name AS myName, age AS myAge FROM 't_student';
    -- 给表起别名 --
    SELECT t.name, t.age FROM 't_student' AS t;
    ```
    
  + limit
    
    ``` sql
    -- 3表示跳过3条数据，2表示取2条数据 --
    SELECT * FROM 't_student' LIMIT 3, 2;
    -- 表示跳过0条数据，即从开头取，取5条数据 --
    SELECT * FROM 't_student' LIMIT 5;
    ```
    
    ​

