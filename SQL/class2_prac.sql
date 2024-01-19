use noob_db;
#-----select all
select * from employee_with_constraints;
#-----describe table structure
desc employee_with_constraints;
#-----add extra column
alter table employee_with_constraints  add result char(2) DEFAULT "P";
#-----modify existing column
alter table employee_with_constraints  modify result varchar(20) DEFAULT "P";
#----------------delete existing column
alter table employee_with_constraints drop column result;
#-----------------add constraint
alter table employee_with_constraints add constraint unque_res UNIQUE(result);
#------------------delete the constraint
alter table employee_with_constraints drop constraint unque_res;

#--------------------Add Customer Table
create table if not exists customer
(
id int,
name varchar(40),
constraint pk Primary Key(id)
)

#----------Add Order Table and foriegn key referencing customer table

CREATE TABLE IF NOT EXISTS orders (
    ord_id INT,
    ord_name VARCHAR(40),
    cust_id INT,
    CONSTRAINT pk_order PRIMARY KEY(ord_id),
    CONSTRAINT fk_customer FOREIGN KEY(cust_id) REFERENCES customer(id)
);

#-----------------difference between drop and truncatae

select * from employee_v1;
#delete all records
truncate employee_v1;
#drop means deletes the table
drop table employee_v1;

#-------------------------------------Total rows in table
select COUNT(*) from employee_with_constraints;

select COUNT(1) from employee_with_constraints;

#Both SELECT COUNT(*) and SELECT COUNT(1) are used to count the number of rows in a table, and in practice, there's typically no significant difference between them. They will both give you the same result— the total number of rows in the specified table.

#How to Optimize sql queries
#select only columns which are necessary


#---------------alias
select name as Distinct_name from employee_with_constraints;

#-----------distinct
select distinct(name) as Distinct_name from employee_with_constraints;

#----calling functions as nested way

select count(distinct(name)) as Distinct_Count from employee_with_constraints;

#---- demo column
select salary as old_salary, salary+10000 as new_Salary from employee_with_constraints;

#----------where clause
select * from employee_with_constraints;

select name from employee_with_constraints where salary >3000;
#few update
UPDATE employee_with_constraints
SET salary = 3000
WHERE salary <= 2000;
#mysql work bench issue 
#SET SQL_SAFE_UPDATES = 0;

#update multiple columns
update employee_with_constraints set name='rahull',salary=3500 where name='Rahul'

#update all rows of salary full update
update employee_with_constraints set hiring_date='2023-01-01';

#usage of limit
select * from employee_with_constraints limit 1;

#order
select * from employee_with_constraints order by salary;

select * from employee_with_constraints order by salary desc;

desc employee_with_constraints;


# Conditional Operators ->    < , > , <= , >= 
# Logical Operator -> AND, OR, NOT

select * from employee_with_constraints;

# list all employees who are getting salary more than 3000
select * from employee_with_constraints where salary>3000;

# list all employees who are getting salary more than or equal to 3000
select * from employee_with_constraints where salary>=3000;

# list all employees who are getting less than 20000
select * from employee_with_constraints where salary<3500;

# list all employees who are getting salary less than or equal to 20000
select * from employee_with_constraints where salary<=3500;


#exactly 5 letters names
select * from employee_with_constraints where name like '_____';



create table orders_data
(
 cust_id int,
 order_id int,
 country varchar(50),
 state varchar(50)
);

alter table orders_data add column bill int default 1000;


insert into orders_data values(1,100,'USA','Seattle');
insert into orders_data values(2,101,'INDIA','UP');
insert into orders_data values(2,103,'INDIA','Bihar');
insert into orders_data values(4,108,'USA','WDC');
insert into orders_data values(5,109,'UK','London');
insert into orders_data values(4,110,'USA','WDC');
insert into orders_data values(3,120,'INDIA','AP');
insert into orders_data values(2,121,'INDIA','Goa');
insert into orders_data values(1,131,'USA','Seattle');
insert into orders_data values(6,142,'USA','Seattle');
insert into orders_data values(7,150,'USA','Seattle');

insert into orders_data values(1,120,'USA','Seattle',1500);
insert into orders_data values(2,121,'INDIA','UP',1200);
insert into orders_data values(2,122,'INDIA','Bihar',2200);
insert into orders_data values(4,123,'USA','WDC',6200);
insert into orders_data values(5,124,'UK','London',89200);
insert into orders_data values(4,125,'USA','WDC',9200);
insert into orders_data values(3,126,'INDIA','AP',200);
insert into orders_data values(2,127,'INDIA','Goa',100);
insert into orders_data values(1,128,'USA','Seattle',9900);
insert into orders_data values(6,129,'USA','Seattle',400);
insert into orders_data values(7,130,'USA','Seattle',200);









select * from orders_data;
select country, count(*) as order_count_by_each_country from orders_data group by country;




SELECT
    state,
    SUM(bill) as total_bill,
    MIN(bill) as min_bill,
    MAX(bill) as max_bill,
    AVG(bill) as avg_bill,
    COUNT(*) as order_count_by_each_state
FROM
    orders_data
GROUP BY
    state;
    
    




select * from orders_data;
select country, count(*) as order_count_by_each_country from orders_data group by country;



#using having
SELECT
    state,
    SUM(bill) as total_bill,
    MIN(bill) as min_bill,
    MAX(bill) as max_bill,
    AVG(bill) as avg_bill,
    COUNT(*) as order_count_by_each_state
FROM
    orders_data
GROUP BY
    state having min_bill >200;
    
#using Group Concat
select country , group_concat(state) from orders_data group by country;
select country , group_concat(distinct state) from orders_data group by country;
select country , group_concat(distinct state order by state desc) from orders_data group by country;
select country , group_concat(distinct state order by state desc separator  '<->') from orders_data group by country;

#case when
select *,
		case
		 when bill >1000 then 'avg'
         when bill >2000 then 'above avg'
         when bill >5000 then 'hit'
        else
        'okokok' end as 'sss'
 from orders_data;


select * from customer;
insert into customer values(1,'shanmukh');
insert into customer values(2,'Aditya');
insert into customer values(3,'Arnav');
insert into customer values(4,'Samaira');
insert into customer values(5,'Shero');
insert into customer values(6,'suan');
insert into customer values(7,'aryin');
insert into customer values(8,'shiba');
insert into customer values(9,'parkeee');
insert into customer values(10,'saeroyi');


select * from orders_data;
desc orders_data;

alter table orders_data add CONSTRAINT fk FOREIGN KEY(cust_id) references customer(id);

#inner

select c.*,o.* from orders_data as o inner join customer as c on
c.id=o.cust_id;

#left
SELECT c.*, o.*
FROM customer AS c
LEFT JOIN orders_data AS o ON c.id = o.cust_id;

select * from customer;
select * from orders_data;

desc customer;
desc orders_data;

select * from customer inner join orders_data on customer.id=orders_data.cust_id