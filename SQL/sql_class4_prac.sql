# Window Functions
create table shop_sales_data
(
sales_date date,
shop_id varchar(5),
sales_amount int
);

insert into shop_sales_data values('2022-02-14','S1',200);
insert into shop_sales_data values('2022-02-15','S1',300);
insert into shop_sales_data values('2022-02-14','S2',600);
insert into shop_sales_data values('2022-02-15','S3',500);
insert into shop_sales_data values('2022-02-18','S1',400);
insert into shop_sales_data values('2022-02-17','S2',250);
insert into shop_sales_data values('2022-02-20','S3',300);

# Total count of sales for each shop using window function
# Working functions - SUM(), MIN(), MAX(), COUNT(), AVG()

select * from shop_sales_data;
select *,
       sum(sales_amount) over(order by sales_amount desc) as running_sum_of_sales
from shop_sales_data;
#when u have same values in the next row it will sum up that why it changed 1500 to 2100
# If we only use Partition By
select *,
       sum(sales_amount) over(partition by shop_id) as total_sum_of_sales
from shop_sales_data;
select *,
       sum(sales_amount) over(partition by shop_id order by sales_amount  ) as total_sum_of_sales,
       max(sales_amount) over(partition by shop_id  order by sales_amount  ) as max_sum_of_sales,
       min(sales_amount) over(partition by shop_id  order by sales_amount  ) as min_sum_of_sales,
       avg(sales_amount) over(partition by shop_id  order by sales_amount  ) as avg_sum_of_sales,
       count(sales_amount) over(partition by shop_id  order by sales_amount  ) as count_sum_of_sales
from shop_sales_data;






create table amazon_sales_data
(
    sales_date date,
    sales_amount int
);
insert into amazon_sales_data values('2022-08-21',500);
insert into amazon_sales_data values('2022-08-22',600);
insert into amazon_sales_data values('2022-08-19',300);
insert into amazon_sales_data values('2022-08-18',200);
insert into amazon_sales_data values('2022-08-25',800);


insert into shop_sales_data values('2022-02-19','S1',400);
insert into shop_sales_data values('2022-02-20','S1',400);
insert into shop_sales_data values('2022-02-22','S1',300);
insert into shop_sales_data values('2022-02-25','S1',200);
insert into shop_sales_data values('2022-02-15','S2',600);
insert into shop_sales_data values('2022-02-16','S2',600);
insert into shop_sales_data values('2022-02-16','S3',500);
insert into shop_sales_data values('2022-02-18','S3',500);
insert into shop_sales_data values('2022-02-19','S3',300);

create table employees1
(
    emp_id int,
    salary int,
    dept_name VARCHAR(30)

);

insert into employees1 values(1,10000,'Software');
insert into employees1 values(2,11000,'Software');
insert into employees1 values(3,11000,'Software');
insert into employees1 values(4,11000,'Software');
insert into employees1 values(5,15000,'Finance');
insert into employees1 values(6,15000,'Finance');
insert into employees1 values(7,15000,'IT');
insert into employees1 values(8,12000,'HR');
insert into employees1 values(9,12000,'HR');
insert into employees1 values(10,11000,'HR');


select * from employees1;
#max salary in each dept
SELECT temp.*
FROM (
  SELECT
    *,
    MAX(salary) OVER (PARTITION BY dept_name) AS max_sal_per_dept,
    ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS row_num
  FROM employees1
) AS temp
WHERE temp.row_num = 1;
#employees holding max salary in each dept
select temp.* from
(select *,rank() over (partition by dept_name order by salary) as emp_rank from employees1 
) AS temp
where temp.emp_rank=1



#employees holding max salary in each dept top 2
select temp1.* from
(select *,dense_rank() over (partition by dept_name order by salary desc) as emp_rank from employees1 
) AS temp1
where temp1.emp_rank<=2
#first value
SELECT
  *,
  FIRST_VALUE(emp_id) OVER (PARTITION BY dept_name ORDER BY salary DESC) AS emp_rank
FROM employees1;


SELECT
  *,
  last_value(emp_id) OVER (PARTITION BY dept_name ORDER BY salary DESC) AS emp_rank
FROM employees1;



create table daily_sales
(
sales_date date,
sales_amount int
);


insert into daily_sales values('2022-03-11',400);
insert into daily_sales values('2022-03-12',500);
insert into daily_sales values('2022-03-13',300);
insert into daily_sales values('2022-03-14',600);
insert into daily_sales values('2022-03-15',500);
insert into daily_sales values('2022-03-16',200);

select * from daily_sales;

select *,
      lag(sales_amount, 1,0) over(order by sales_date) as pre_day_sales
from daily_sales;



SELECT * FROM noob_db.pak_dt;
select price,category_name_1,sku, first_value(sku) over (partition by category_name_1 order by price desc) as category from noob_db.pak_dt;

use noob_db;

delete from pak_dt where category_name_1='\\N';

select COUNT(*),category_name_1 from pak_dt group by category_name_1;

select * from pak_dt;
#by default it works like this
select sku,price,category_name_1, first_value(sku) over (partition by category_name_1 order by price desc) as product_first,
last_value(sku) over (partition by category_name_1 order by price ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as product_last
from pak_dt;
#lets change
select sku,price,category_name_1, first_value(sku) over (partition by category_name_1 order by price desc) as product_first,
last_value(sku) over (partition by category_name_1 order by price desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as product_last
from pak_dt;



-- Creating a temporary table with sample data
CREATE TEMPORARY TABLE noob_db.sample_data (
    id INT,
    value INT
);

-- Inserting sample data
INSERT INTO noob_db.sample_data (id, value)
VALUES
    (1, 10),
    (2, 20),
    (3, 30),
    (4, 40),
    (5, 50),
    (6, 60),
    (7, 70),
    (8, 80),
    (9, 90),
    (10, 100);

use noob_db;
-- Query with window function using "2 PRECEDING AND 2 FOLLOWING"
SELECT
    id,
    value,
    SUM(value) OVER (ORDER BY id RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS running_sum,
    SUM(value) OVER (ORDER BY id ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS running_sum_rowws,
    nth_value(value, 2)  OVER (ORDER BY value DESC RANGE BETWEEN UNBOUNDED PRECEDING AND  UNBOUNDED FOLLOWING) AS nth,
    cume_dist() over (order by value desc) as cum_dist,
    round(cume_dist() over (order by value desc)*100 ,2) as cum_dist_1
FROM
    sample_data;


SELECT
    id,
    value,
    SUM(value) OVER (ORDER BY id RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS running_sum,
    nth_value(value, 2)  OVER (ORDER BY value DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED following) AS nth,
    NTILE(3) OVER (ORDER BY value desc) as ntiled
FROM
    sample_data;