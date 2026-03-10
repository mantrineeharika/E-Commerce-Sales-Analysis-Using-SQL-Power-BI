📦 E-Commerce Sales Analysis (SQL + Power BI)

An end-to-end E-Commerce Data Analytics Project built using SQL for data extraction and Microsoft Power BI for data visualization.
This project analyzes customer behavior, product performance, sales trends, and overall business performance using a structured relational database and interactive dashboard.

🔍 Project Overview

This project focuses on analyzing an E-commerce platform’s sales and customer activity data.
A relational SQL database was created with tables for users, products, orders, reviews, and user events.
SQL queries were used to extract insights, and a Power BI dashboard visualizes KPIs such as Total Revenue, Total Orders, Average Order Value, Top Products, Monthly Sales Trend, and Conversion Rate.

The goal is to demonstrate end-to-end data analytics skills including:

Database design

SQL querying

Data modeling

KPI creation

Dashboard building

Business insights

📂 Dataset Description

The project uses 6 main tables:

Table	Description
users	Customer details such as name, email, city, gender
products	Product info: category, brand, price, rating
orders	Order-level data including status and timestamp
order_items	Line-item details such as item price, quantity, totals
events	User interactions: view, cart, wishlist, purchase
reviews	Ratings and review text for products

🛠 Tools & Technologies

SQL (MySQL)

Microsoft Power BI

Excel / CSV

DAX (for KPIs)

Data Modeling

🗄 Database Schema

The SQL database includes these main relationships:

users (1) ──── (many) orders
orders (1) ─── (many) order_items
products (1) ─ (many) order_items
products (1) ─ (many) reviews
users (1) ──── (many) events

📊 Power BI Dashboard Visuals

The interactive dashboard includes:

KPI Cards: Revenue, Orders, AOV, Units Sold

Line Chart: Monthly sales trend

Bar Chart: Sales by product category

Column Chart: Top 10 products

Donut Chart: Order status distribution

Table: Product details with revenue and ratings

Funnel Chart: View → Cart → Purchase conversion

Slicers: Month, Category

💡 Insights

Key findings from the analysis:

Electronics & Fashion are top-performing categories

Certain products contribute a major portion of revenue

A significant number of customers are repeat buyers

Product ratings influence purchase behavior

Conversion from view → purchase shows improvement opportunities

🏁 Conclusion

This project showcases how SQL and Microsoft Power BI can be used together to build a full-scale analytical solution.
By transforming raw e-commerce data into visual insights, businesses can make data-driven decisions to optimize sales, improve customer experience, and grow revenue.
