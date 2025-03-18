college@cec:~$ sudo mysql -u root
[sudo] password for college: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.42-0ubuntu0.18.04.1 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use Bank;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> desc tables;
ERROR 1146 (42S02): Table 'Bank.tables' doesn't exist
mysql> desc table;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'table' at line 1
mysql> show tables;
+----------------+
| Tables_in_Bank |
+----------------+
| Borrow         |
| Branch1        |
| Deposit        |
| branch3        |
| cust1          |
| customer       |
| depo1          |
+----------------+
7 rows in set (0.00 sec)

mysql> select * from Borrow;
+---------+---------+-----------+--------+
| Loan_no | Cust_id | Branch_id | Amount |
+---------+---------+-----------+--------+
| 301     | 1       | 103       | 100000 |
| 302     | 3       | 104       | 200000 |
| 303     | 5       | 106       | 150000 |
| 304     | 6       | 107       |  80000 |
| 305     | 8       | 109       | 950000 |
| 306     | 9       | 110       | 300000 |
| 307     | 2       | 102       | 175000 |
| 308     | 4       | 105       | 120000 |
| 309     | 7       | 108       |  60000 |
| 310     | 10      | 101       |  40000 |
+---------+---------+-----------+--------+
10 rows in set (0.00 sec)

mysql> select sum(amount) as total_loan from Borrow;
+------------+
| total_loan |
+------------+
|    2175000 |
+------------+
1 row in set (0.02 sec)

mysql> select sum(amount) as total_deposit from Deposit;
+---------------+
| total_deposit |
+---------------+
|        352550 |
+---------------+
1 row in set (0.00 sec)

mysql> select max(d.amount)as max_deposit from Deposit d join customer c on d.cust_id = c.cust_id where c.city ='Ernakulam';
+-------------+
| max_deposit |
+-------------+
|        NULL |
+-------------+
1 row in set (0.04 sec)

mysql> select max(amount)as max_deposit from Deposit d join customer c on d.cust_id = c.cust_id where c.city ='Ernakulam';
+-------------+
| max_deposit |
+-------------+
|        NULL |
+-------------+
1 row in set (0.00 sec)

mysql> select count(Distinct city)as Total_branch_citites from Branch;
ERROR 1146 (42S02): Table 'Bank.Branch' doesn't exist
mysql> select count(Distinct(city))as Total_branch_citites from Branch;
ERROR 1146 (42S02): Table 'Bank.Branch' doesn't exist
mysql> select count(Distinct(city))as Total_branch_citites from Branch1;
+----------------------+
| Total_branch_citites |
+----------------------+
|                   10 |
+----------------------+
1 row in set (0.00 sec)

mysql> select count(Distinct(city))as Total_branch_citites from Branch1;
+----------------------+
| Total_branch_citites |
+----------------------+
|                   10 |
+----------------------+
1 row in set (0.00 sec)

mysql> select count(Distinct city)as Total_branch_citites from Branch;
ERROR 1146 (42S02): Table 'Bank.Branch' doesn't exist
mysql> select count(Distinct(city))as Total_branch_citites from Branch1;
+----------------------+
| Total_branch_citites |
+----------------------+
|                   10 |
+----------------------+
1 row in set (0.00 sec)

mysql> select Branch_id,sum(amount)as Total_deposit from deposit group by Branch_id;
ERROR 1146 (42S02): Table 'Bank.deposit' doesn't exist
mysql> select Branch_id,sum(amount)as Total_deposit from Deposit group by Branch_id;
+-----------+---------------+
| Branch_id | Total_deposit |
+-----------+---------------+
| 101       |          9900 |
| 102       |         30250 |
| 103       |         16500 |
| 104       |          5500 |
| 105       |         49500 |
| 106       |         66000 |
| 107       |         82500 |
| 108       |         24200 |
| 109       |         60500 |
| 110       |          7700 |
+-----------+---------------+
10 rows in set (0.00 sec)

mysql> select Branch_id from Deposit group by Branch_id having sum(amount)>4000; 
+-----------+
| Branch_id |
+-----------+
| 101       |
| 102       |
| 103       |
| 104       |
| 105       |
| 106       |
| 107       |
| 108       |
| 109       |
| 110       |
+-----------+
10 rows in set (0.00 sec)

mysql> select c.c_name from customer c join Deposit d on c.cust_id = d.cust_id where d.amount =(select min(amount) from Deposit);
+--------+
| c_name |
+--------+
| Ramesh |
+--------+
1 row in set (0.01 sec)

mysql> select count(Distinct(d.cust_id))as Depositor_count from Deposit d join customer c on d.cust_id =c.cust_id where c.city='cherthala';
+-----------------+
| Depositor_count |
+-----------------+
|               0 |
+-----------------+
1 row in set (0.00 sec)

mysql> select count(Distinct(d.cust_id))as Depositor_count from Deposit d join customer c on d.cust_id =c.cust_id where c.city='Cherthala';
+-----------------+
| Depositor_count |
+-----------------+
|               0 |
+-----------------+
1 row in set (0.00 sec)

mysql> select * from Deposit;
+--------+---------+--------+-----------+------------+
| Acc_no | cust_id | Amount | Branch_id | open_date  |
+--------+---------+--------+-----------+------------+
| 201    | 1       |  16500 | 103       | 2018-06-15 |
| 202    | 2       |  30250 | 102       | 2017-02-10 |
| 203    | 3       |   5500 | 104       | 2019-11-20 |
| 204    | 4       |  49500 | 105       | 2020-12-01 |
| 205    | 5       |  66000 | 106       | 2015-09-30 |
| 206    | 6       |  82500 | 107       | 2014-07-07 |
| 207    | 7       |  24200 | 108       | 2021-08-12 |
| 208    | 8       |  60500 | 109       | 2013-05-05 |
| 209    | 9       |   7700 | 110       | 2022-10-23 |
| 210    | 10      |   9900 | 101       | 2011-03-17 |
+--------+---------+--------+-----------+------------+
10 rows in set (0.00 sec)

mysql> select * from customer;
+---------+--------+-----------+
| cust_id | c_name | city      |
+---------+--------+-----------+
| 1       | Anil   | Kochi     |
| 10      | Naveen | kollam    |
| 12      | santi  | New York  |
| 2       | Suresh | Aroor     |
| 3       | Ramesh | Chennai   |
| 4       | Salim  | mumbai    |
| 5       | kiran  | Bangalore |
| 6       | Akash  | Delhi     |
| 7       | Rahul  | Hydrabad  |
| 8       | Shyam  | Pune      |
| 9       | varun  | kolkata   |
+---------+--------+-----------+
11 rows in set (0.00 sec)

mysql> update set city='Alappuzha' where cust_id='2';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'set city='Alappuzha' where cust_id='2'' at line 1
mysql> update customer set city='Alappuzha' where cust_id='2';
Query OK, 1 row affected (0.07 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from customer;
+---------+--------+-----------+
| cust_id | c_name | city      |
+---------+--------+-----------+
| 1       | Anil   | Kochi     |
| 10      | Naveen | kollam    |
| 12      | santi  | New York  |
| 2       | Suresh | Alappuzha |
| 3       | Ramesh | Chennai   |
| 4       | Salim  | mumbai    |
| 5       | kiran  | Bangalore |
| 6       | Akash  | Delhi     |
| 7       | Rahul  | Hydrabad  |
| 8       | Shyam  | Pune      |
| 9       | varun  | kolkata   |
+---------+--------+-----------+
11 rows in set (0.00 sec)

mysql> select max(amount) as max_deposit from Deposit where Branch_id =(select Brnch_id from Branch where city='Alappuzha');
ERROR 1146 (42S02): Table 'Bank.Branch' doesn't exist
mysql> select max(amount) as max_deposit from Deposit where Branch_id =(select Brnch_id from Branch1 where city='Alappuzha');
ERROR 1054 (42S22): Unknown column 'Brnch_id' in 'field list'
mysql> select * from Branch1;
+-----------+------------+-----------+
| Branch_id | bname      | city      |
+-----------+------------+-----------+
| 101       | cherthala  | Alappuzha |
| 102       | Aroor      | Ernakulam |
| 103       | MG Road    | Kochi     |
| 104       | Anna Nagar | cheenai   |
| 105       | Banndra    | Mumbai    |
| 106       | BTM Layout | Bangalore |
| 107       | Connaught  | Delhi     |
| 108       | Begumpet   | Hydrabad  |
| 109       | koregaon   | pune      |
| 110       | Salt Lake  | Kolkata   |
+-----------+------------+-----------+
10 rows in set (0.00 sec)

mysql> select max(amount) as max_deposit from Deposit where Branch_id =(select Branch_id from Branch1 where city='Alappuzha');
+-------------+
| max_deposit |
+-------------+
|        9900 |
+-------------+
1 row in set (0.00 sec)

mysql> select count(*) as customer_count from customer where city='ernakulam';
+----------------+
| customer_count |
+----------------+
|              0 |
+----------------+
1 row in set (0.00 sec)

mysql> select count(*) as customer_count from customer where city='Ernakulam';
+----------------+
| customer_count |
+----------------+
|              0 |
+----------------+
1 row in set (0.00 sec)

mysql> select * from customer;
+---------+--------+-----------+
| cust_id | c_name | city      |
+---------+--------+-----------+
| 1       | Anil   | Kochi     |
| 10      | Naveen | kollam    |
| 12      | santi  | New York  |
| 2       | Suresh | Alappuzha |
| 3       | Ramesh | Chennai   |
| 4       | Salim  | mumbai    |
| 5       | kiran  | Bangalore |
| 6       | Akash  | Delhi     |
| 7       | Rahul  | Hydrabad  |
| 8       | Shyam  | Pune      |
| 9       | varun  | kolkata   |
+---------+--------+-----------+
11 rows in set (0.00 sec)

mysql> update customer set city='ernakulam' where c_name='Shyam';
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from customer;
+---------+--------+-----------+
| cust_id | c_name | city      |
+---------+--------+-----------+
| 1       | Anil   | Kochi     |
| 10      | Naveen | kollam    |
| 12      | santi  | New York  |
| 2       | Suresh | Alappuzha |
| 3       | Ramesh | Chennai   |
| 4       | Salim  | mumbai    |
| 5       | kiran  | Bangalore |
| 6       | Akash  | Delhi     |
| 7       | Rahul  | Hydrabad  |
| 8       | Shyam  | ernakulam |
| 9       | varun  | kolkata   |
+---------+--------+-----------+
11 rows in set (0.00 sec)

mysql> select count(*) as customer_count from customer where city='Ernakulam';
+----------------+
| customer_count |
+----------------+
|              1 |
+----------------+
1 row in set (0.00 sec)

mysql> select cust_id,c_name,city from customer where city not in ('ernakulam','Alappuzha');
+---------+--------+-----------+
| cust_id | c_name | city      |
+---------+--------+-----------+
| 1       | Anil   | Kochi     |
| 10      | Naveen | kollam    |
| 12      | santi  | New York  |
| 3       | Ramesh | Chennai   |
| 4       | Salim  | mumbai    |
| 5       | kiran  | Bangalore |
| 6       | Akash  | Delhi     |
| 7       | Rahul  | Hydrabad  |
| 9       | varun  | kolkata   |
+---------+--------+-----------+
9 rows in set (0.00 sec)

mysql> select cust_id,c_name from customer order by c_name desc;
+---------+--------+
| cust_id | c_name |
+---------+--------+
| 9       | varun  |
| 2       | Suresh |
| 8       | Shyam  |
| 12      | santi  |
| 4       | Salim  |
| 3       | Ramesh |
| 7       | Rahul  |
| 10      | Naveen |
| 5       | kiran  |
| 1       | Anil   |
| 6       | Akash  |
+---------+--------+
11 rows in set (0.00 sec)

mysql> select branch_id,count(Distinct cust_id)as depositor_count from Deposit group by Branch_id;
+-----------+-----------------+
| branch_id | depositor_count |
+-----------+-----------------+
| 101       |               1 |
| 102       |               1 |
| 103       |               1 |
| 104       |               1 |
| 105       |               1 |
| 106       |               1 |
| 107       |               1 |
| 108       |               1 |
| 109       |               1 |
| 110       |               1 |
+-----------+-----------------+
10 rows in set (0.00 sec)

mysql> select Branch_id from Branch where Branch_id not in (select Distinct Branch_id from Borrow);
ERROR 1146 (42S02): Table 'Bank.Branch' doesn't exist
mysql> select Branch_id from Branch1 where Branch_id not in (select Distinct Branch_id from Borrow);
Empty set (0.00 sec)

mysql> select Branch_id from Branch1 where Branch_id not in (select Distinct Branch_id from Borrow);
Empty set (0.00 sec)

mysql> select * from Branch1;
+-----------+------------+-----------+
| Branch_id | bname      | city      |
+-----------+------------+-----------+
| 101       | cherthala  | Alappuzha |
| 102       | Aroor      | Ernakulam |
| 103       | MG Road    | Kochi     |
| 104       | Anna Nagar | cheenai   |
| 105       | Banndra    | Mumbai    |
| 106       | BTM Layout | Bangalore |
| 107       | Connaught  | Delhi     |
| 108       | Begumpet   | Hydrabad  |
| 109       | koregaon   | pune      |
| 110       | Salt Lake  | Kolkata   |
+-----------+------------+-----------+
10 rows in set (0.00 sec)

mysql> select * from Borrow;
+---------+---------+-----------+--------+
| Loan_no | Cust_id | Branch_id | Amount |
+---------+---------+-----------+--------+
| 301     | 1       | 103       | 100000 |
| 302     | 3       | 104       | 200000 |
| 303     | 5       | 106       | 150000 |
| 304     | 6       | 107       |  80000 |
| 305     | 8       | 109       | 950000 |
| 306     | 9       | 110       | 300000 |
| 307     | 2       | 102       | 175000 |
| 308     | 4       | 105       | 120000 |
| 309     | 7       | 108       |  60000 |
| 310     | 10      | 101       |  40000 |
+---------+---------+-----------+--------+
10 rows in set (0.00 sec)

mysql> insert into Branch1 values(111,'Ezupunna','USA');
Query OK, 1 row affected (0.05 sec)

mysql> select Branch_id from Branch1 where Branch_id not in (select Distinct Branch_id from Borrow);
+-----------+
| Branch_id |
+-----------+
| 111       |
+-----------+
1 row in set (0.00 sec)

mysql> select count(Distinct(cust_id))as New_depostors from Deposit where open_date>'2016-01-01';
+---------------+
| New_depostors |
+---------------+
|             6 |
+---------------+
1 row in set (0.00 sec)

mysql> select max(d.amount)as max_deposit from deposit d join customer c on d.cust_id =c.cust_id where c.city='Ernakulam';
ERROR 1146 (42S02): Table 'Bank.deposit' doesn't exist
mysql> select max(d.amount)as max_deposit from Deposit d join customer c on d.cust_id =c.cust_id where c.city='Ernakulam';
+-------------+
| max_deposit |
+-------------+
|       60500 |
+-------------+
1 row in set (0.24 sec)

mysql> create database bale;
Query OK, 1 row affected (0.05 sec)

mysql> use bale;
Database changed
mysql> create table Location(Location_id int,Regional_group varchar(20));
Query OK, 0 rows affected (0.45 sec)

mysql> create table Department(Department_id int,Name varchar(20),Location_id int);
Query OK, 0 rows affected (0.24 sec)

mysql> create table job(Job_id int,Function Varchar(30));
Query OK, 0 rows affected (0.29 sec)

mysql> Create table Employee(Employee_id int,FirstName varchar(25),Lastname varchar(25),Middlename varchar(12),Job_id int,Manager_id int,Hiredate date,Salary int,Department_id int);
Query OK, 0 rows affected (0.32 sec)

mysql> create table Loan(Employee_id int,Firstname varchar(25),Loan_Amount(int));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(int))' at line 1
mysql> create table Loan(Employee_id int,Firstname varchar(25),Loan_Amount(int));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(int))' at line 1
mysql> create table Loan(Employee_id int,Firstname varchar(25),Loan_Amount int); 
Query OK, 0 rows affected (0.29 sec)

mysql> desc Loan;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| Employee_id | int(11)     | YES  |     | NULL    |       |
| Firstname   | varchar(25) | YES  |     | NULL    |       |
| Loan_Amount | int(11)     | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+
3 rows in set (0.03 sec)

mysql> 
mysql> desc Employee;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| Employee_id   | int(11)     | YES  |     | NULL    |       |
| FirstName     | varchar(25) | YES  |     | NULL    |       |
| Lastname      | varchar(25) | YES  |     | NULL    |       |
| Middlename    | varchar(12) | YES  |     | NULL    |       |
| Job_id        | int(11)     | YES  |     | NULL    |       |
| Manager_id    | int(11)     | YES  |     | NULL    |       |
| Hiredate      | date        | YES  |     | NULL    |       |
| Salary        | int(11)     | YES  |     | NULL    |       |
| Department_id | int(11)     | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
9 rows in set (0.02 sec)

