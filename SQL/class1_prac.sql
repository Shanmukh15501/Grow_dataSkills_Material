#------Show the Database-----------
show databases;
#------Create the Database-----------
create database noob_db1;
#------drop the Database-----------
drop database noob_db1;
#------use the Database-----------
use noob_db;
#---------CREATE table
CREATE TABLE IF NOT exists employee
(
id int,
emp_name varchar(20)
);

#-----show tables
show tables;

#-- i want to see only table defnition
show create table employee;

#--Create Table with more columns
create table if not exists employee_v1
(
id int,
name varchar(20),
salary double,
hiring_data DATE
)
#------------------------- insert data into above table
INSERT INTO employee_v1 VALUES(2, 'Shanmukh', 90000, '1997-08-21')
#------------------------- select data into above table
select * from employee_v1;
#------------------------- insert data into specific columns in  table
INSERT INTO employee_v1(id,name,salary) VALUES (3, 'Shanmukh', 90);
#-------------------------- insert multiple records at a time
INSERT INTO employee_v1 VALUES (4, 'Shanmukh', 90000, '1997-08-21'),(5, 'Shanmukh', 90000, '1997-08-21'),(6, 'Shanmukh', 90000, '1997-08-21')
#--------------------create another table for integrity constraints
CREATE TABLE if not EXISTS employee_with_constraints(
	id INT,
    name VARCHAR(50) NOT NULL,
    salary DOUBLE, 
    hiring_date DATE DEFAULT '2021-01-01',
    UNIQUE (id),
    CHECK (salary > 1000)
);
#--- Example 1 for IC failure
#--- Exception - Column 'name' cannot be null
insert into employee_with_constraints values(1,null,3000,'2021-11-20');

#--- Correct record
insert into employee_with_constraints values(1,'shanu',3000,'2021-11-20');

#--- Example 2 for IC failure
#--- Exception - Duplicate entry '1' for key 'employee_with_constraints.id'
insert into employee_with_constraints values(1,'Rahul',5000,'2021-10-23');

--- Another correct record because Unique can accept NULL as well
insert into employee_with_constraints 
values(null,'Rahul',5000,'2021-10-23');

--- Example 3 for IC failure
--- Exception - Duplicate entry NULL for key 'employee_with_constraints.id'
insert into employee_with_constraints 
values(null,'Rajat',2000,'2020-09-20');


--- Example 4 for IC failure
--- Exception - Check constraint 'employee_with_constraints_chk_1' is violated
insert into employee_with_constraints 
values(5,'Amit',500,'2023-10-24');

--- Test IC for default date
insert into employee_with_constraints(id,name,salary)
values(7,'Neeraj',3000);

select * from employee_with_constraints;

