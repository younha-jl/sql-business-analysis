# SQL E-Commerce Business Intelligence Analysis
 
## Project Overview
This project showcase how to use **SQL** to analyze e-commerce retail sales data and extract actionable business insights.
To keep the data clean and organized, the raw dataset was structured into a classic "star schema" with two tables:
1. **'customers'**: Holds shopper demographic data.
2. **'sales'**: Holds the transactional history.
 
the goal of this analysis is to transform raw rows of data into useful business metrics: tracking sales trends, understanding customer demographics, and identifying which product categories drive the most revenue.
 
---
 
## Tech Stack & Skills Demonstrated
* **Database Modeling:** Relational design, Primary/Foreign Key constraints, Data normalization
* **Analytical SQL:** Multi-table `JOIN` operations, conditional `CASE WHEN` logic, data aggregations (`GROUP BY`, `HAVING`), and **Common Table Expressions (CTEs)**
 
---
 
## Database Architecture & Schema
The data model has been optimized for analytical queries by separating transactional facts from user dimensions:
 
### 1. `customers` (Dimension Table)
* `customer_id` (VARCHAR, Primary Key) — Unique identifier for each shopper
* `gender` (VARCHAR) — Customer gender
* `age` (INT) — Customer age
 
### 2. `sales` (Fact Table)
* `transaction_id` (INT, Primary Key) — Unique transaction identifier
* `sale_date` (DATE) — Date of the purchase
* `customer_id` (VARCHAR, Foreign Key) — Links back to the customer profile
* `product_category` (VARCHAR) — Product track (Beauty, Clothing, Electronics)
* `quantity` (INT) — Number of units purchased
* `price_per_unit` (DECIMAL) — Price per individual item
* `total_amount` (DECIMAL) — Total financial value of the transaction
 
---
 
## Business Questions Answered & Code Highlights
 
### 1. Core Product Category Performance
* **Objective:** Identify which product categories drive the highest order volume and total revenue.
* **SQL Focus:** `SELECT`, `SUM()`, `COUNT()`, `GROUP BY`, `ORDER BY`.
```sql
SELECT
    product_category,
    COUNT(transaction_id) AS total_orders,
    SUM(quantity) AS total_items_sold,
    SUM(total_amount) AS total_revenue
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC;
