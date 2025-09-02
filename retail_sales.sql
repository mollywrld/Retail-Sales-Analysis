SELECT * FROM mydb.retailsales;
SELECT * FROM mydb.retailsales LIMIT 3;

SELECT * FROM mydb.retailsales where sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantity is null or price_per_unit is null or cogs is null or total_sale is null;
SELECT COUNT(DISTINCT customer_id) as total_sale FROM mydb.retailsales;

SELECT DISTINCT category FROM mydb.retailsales;
select * from mydb.retailsales where sale_date='2022-11-05';

ALTER TABLE mydb.retailsales RENAME COLUMN quantiy TO quantity;

select * from mydb.retailsales where category='Clothing' and date_format(sale_date, '%Y-%m')='2022-11' and quantity>=4;

select category, sum(total_sale) as net_sales, count(*) as total_orders from mydb.retailsales group by category;

select round(avg(age),0) as avg_age from mydb.retailsales where category='Beauty';

select total_sale, count(*) as transactions_above_1000 from mydb.retailsales where total_sale>=1000 group by total_sale;
-- SQL QUERY TO FIND THE TOTAL NO. OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY
select category, gender, count(*) as total_transactions from mydb.retailsales group by category, gender order by 1;
-- SQL QUERY TO CALCULATE THE AVG SALE FOR EACH MONTH, FIND OUT BEST SELLING MONTH IN EACH YEAR
select extract(year from sale_date) as year, extract(month from sale_date) as month, avg(total_sale) as avg_sales from mydb.retailsales group by 1,2 order by 1,3 desc;
-- SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
select customer_id, sum(total_sale) as net_sales from mydb.retailsales group by 1 order by 2 desc limit 5;

-- SQL QUERY TO FIND THE NUM OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY
select count(distinct customer_id) as unique_cust, category from mydb.retailsales group by category;

-- SQL QUERY TO CREATE EACH SHIFT AND NUM OF ORDERS (Ex: morning <=12pm, afternoon between 12&17, evening>17:00)
WITH hourly_sale AS 
(SELECT *,
 CASE 
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift
FROM mydb.retailsales
)
SELECT shift, count(*) as total_orders FROM hourly_sale group by shift;
 