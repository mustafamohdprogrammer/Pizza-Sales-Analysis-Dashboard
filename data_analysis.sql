select * from pizza_sales

select sum(total_price) as [Total Price] from pizza_sales

select sum(total_price) / count(distinct order_id) as [Avg Order Value] from pizza_sales

select sum(quantity) as [Total Pizza Sold] from pizza_sales

select count(distinct order_id) as Total_orders from pizza_Sales

select cast(cast(sum(quantity) as decimal(10,2)) /
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as avg_pizza_per_order from pizza_sales


-- Daily Trends
select
	datename(dw,order_date) as order_date,
	count(distinct order_id) as Total_orders
from pizza_sales
group by datename(dw,order_date);


-- Hourly Trends
select
	datepart(hour,order_time) as order_Hour,
	count(distinct order_id) as Total_orders
from pizza_sales
group by datepart(hour,order_time)
order by datepart(hour,order_time)


-- percentage of pizza sales by category
select 
	pizza_category,
	sum(total_price) as Total_Sales,
	cast(sum(total_price) * 100 / cast((select sum(total_price) from pizza_sales)as decimal(10,2))as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
where month(order_date) = 1
group by pizza_category;

select 
	pizza_category,
	sum(total_price) as Total_Sales,
	cast(sum(total_price) * 100 / cast((select sum(total_price) from pizza_sales where month(order_date) = 1)as decimal(10,2))as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
where month(order_date) = 1
group by pizza_category;


-- percentage of pizza sales by Size
select 
	pizza_size,
	cast(sum(total_price)as decimal(10,2)) as Total_Sales,
	cast(sum(total_price) * 100 / cast((select 
											sum(total_price) 
										from pizza_sales)as decimal(10,2))as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
group by pizza_size
order by percentage_of_total_sales desc

select 
	pizza_size,
	cast(sum(total_price)as decimal(10,2)) as Total_Sales,
	cast(sum(total_price) * 100 / cast((select
											sum(total_price) 
										from pizza_sales 
										where datepart(quarter,order_date) = 1)as decimal(10,2))as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
where datepart(quarter,order_date) = 1
group by pizza_size
order by percentage_of_total_sales desc



-- total pizza sold by pizza category
select
	pizza_category,
	sum(quantity)
from pizza_sales
group by pizza_category;


-- Top 5 best seller
select
	top 5
	pizza_name,
	sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by sum(Quantity) desc



-- Top 5 worst seller
select
	top 5
	pizza_name,
	sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by sum(Quantity) asc