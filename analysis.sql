-- ====================================================================
-- 1. BASIC AGGREGATIONS (SELECT & GROUP BY)
-- Goal: Identify the top-performing product categories by total revenue
-- ====================================================================

SELECT 
    product_category,
    COUNT(transaction_id) AS total_orders,
    SUM(quantity) AS total_items_sold,
    SUM(total_amount) AS total_revenue
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC;


-- ====================================================================
-- 2. DEMOGRAPHIC ANALYSIS (JOIN & GROUP BY)
-- Goal: Analyze purchasing behavior across different age groups and genders
-- ====================================================================

SELECT 
    c.gender,
    CASE 
        WHEN c.age < 30 THEN 'Under 30'
        WHEN c.age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(s.transaction_id) AS total_transactions,
    ROUND(AVG(s.total_amount), 2) AS average_basket
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.gender, age_group
ORDER BY age_group, total_transactions DESC;


-- ====================================================================
-- 3. ADVANCED BUSINESS METRICS (CTEs & WINDOW FUNCTIONS)
-- Goal: Segment customers based on their high-value spending (RFM drop-in)
-- ====================================================================

WITH CustomerSpending AS (
    SELECT 
        customer_id,
        COUNT(transaction_id) AS purchase_frequency,
        SUM(total_amount) AS total_customer_spend
    FROM sales
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.age,
    c.gender,
    cs.purchase_frequency,
    cs.total_customer_spend,
    CASE 
        WHEN cs.total_customer_spend >= 500 THEN 'VIP Gold'
        WHEN cs.total_customer_spend BETWEEN 200 AND 499 THEN 'Regular Buyer'
        ELSE 'Occasional Customer'
    END AS customer_segment
FROM customers c
JOIN CustomerSpending cs ON c.customer_id = cs.customer_id
ORDER BY cs.total_customer_spend DESC
LIMIT 10;