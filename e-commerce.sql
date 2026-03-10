create database ecommerce;
use ecommerce;
CREATE TABLE events (
    event_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20),
    product_id VARCHAR(20),
    event_type VARCHAR(50),
    event_timestamp DATETIME(6)
);
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    gender VARCHAR(20),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20),
    order_date DATETIME(6),
    order_status VARCHAR(20),
    total_amount int not null
);

create table order_items(
             order_item_id	VARCHAR(20),
             order_id VARCHAR(20),
             product_id	VARCHAR(20),
             user_id	VARCHAR(20),
             quantity	int not null,
             item_price	int not null,
             item_total int not null
);

create table products(
             product_id	VARCHAR(20),
             product_name VARCHAR(20),	
             category	VARCHAR(20),
             brand	VARCHAR(20),
             price	int not null,
             rating int not null
);

create table reviews(
             review_id	VARCHAR(20),
             order_id	VARCHAR(20),
             product_id	VARCHAR(20),
             user_id	VARCHAR(20),
             rating	 int not null,
             review_text VARCHAR(20),	
             review_date DATETIME(6)
);

select * from events;
select * from users;
select * from orders;
select * from order_items;
select * from products;
select * from reviews;

# An SQL query to join orders and users tables to show order details with customer name.
select order_id, 
       order_status, 
       order_date, 
       name as customer_name
from orders as o
join users as u on o.user_id=u.user_id;

# An order details with product information.
select o.order_id, 
       o.order_date, 
       p.product_id, 
       p.product_name, 
       oi.quantity, 
       oi.item_price, 
       oi.item_total
from orders as o 
join order_items as oi on o.order_id=oi.order_id
join products as p on oi.product_id=p.product_id; 

# Total revenue for each product.
select p.product_id, 
	   p.product_name, 
       sum(oi.quantity * p.price) as revenue
from order_items as oi
join products as p on oi.product_id=p.product_id
group by product_id, product_name
order by revenue desc;

# Total orders placed by each user.
select u.user_id,
       name,
       count(o.order_id) as total_orders
from users as u
left join orders as o on u.user_id=o.user_id
group by u.user_id, name;

# Get product reviews with customer name.
select r.review_id, 
       p.product_name,
       u.name,
       r.rating,
       r.review_date
from users as u
join reviews as r on u.user_id=r.user_id
join products as p on r.product_id=p.product_id;

# Average rating of each product.
select p.product_id,
	   p.product_name,
       round(avg(r.rating),0) as avg_rating
from products as p
left join reviews as r on p.product_id=r.product_id
group by p.product_id, p.product_name; 

# Get user activity (events) with product details.
select e.event_id, 
       e.event_type,
       u.name,
       p.product_name
from users as u
join events as e on u.user_id=e.user_id
join products as p on e.product_id=p.product_id;

# Total revenue per category.
select p.category,
       sum(oi.quantity * p.price) as total_revenue
from order_items as oi
join products as p on oi.product_id=p.product_id
group by p.category;

# Customers who have not placed any orders.
select u.user_id,
	   name
from users as u
left join orders as o on u.user_id=o.user_id
where o.order_id is null;

# Top 10 customers by spending.
select u.user_id,
       name,
       sum(oi.item_total) as total_spent
from users as u
join orders as o on u.user_id=o.user_id
join order_items as oi on o.order_id=oi.order_id
group by u.user_id, name
order by total_spent desc
limit 10;

# Find repeat customers.
select u.user_id,
       name,
       count(o.order_id) as total_orders
from users as u
join orders as o on u.user_id=o.user_id
group by u.user_id, name
having total_orders > 1;

# Monthly revenue trend.
select extract(month from o.order_date) as month,
	   sum(oi.item_total) as revenue
from orders as o
join order_items as oi on o.order_id=oi.order_id
group by month
order by month;

# Top 5 selling products based on quantity.
select p.product_id,
       p.product_name,
       sum(oi.quantity) as total_quantity
from products as p
join order_items as oi on p.product_id=oi.product_id
group by p.product_id, p.product_name
order by total_quantity desc
limit 5;

# Conversion rate from events table.
select count(case when event_type = 'view' then 1 end) as views,
       count(case when event_type = 'cart' then 1 end) as add_to_cart,
       count(case when event_type = 'purchase' then 1 end) as purchases,
       round((count(case when event_type = 'purchase' then 1 end) /
			 count(case when event_type = 'view' then 1 end)) * 100, 2) as conversion_percent
from events;

# Rank products by revenue.
select p.product_name,
       sum(oi.item_total) as revenue,
       rank() over(order by sum(oi.item_total) desc) as revenue_rank
from products as p
join order_items as oi on p.product_id=oi.product_id
group by p.product_name;

# Month-on-month revenue growth.
WITH monthly as (
    select 
        extract(month from o.order_date) as month,
        sum(oi.item_total) AS revenue
    from orders o
    join order_items oi on o.order_id = oi.order_id
    group by month
)
select 
    month,
    revenue,
    lag(revenue) over(order by month) AS prev_month_revenue,
    (revenue - lag(revenue) over(order by month)) AS growth
from monthly;