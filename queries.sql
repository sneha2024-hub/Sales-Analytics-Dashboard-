-- =========================================
-- Global Retail Sales Analytics - SQL Queries
-- =========================================

-- 1. Total Revenue
SELECT 
    SUM(od.unit_price * od.quantity) AS total_revenue
FROM order_details od;


-- 2. Total Orders
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o;


-- 3. Total Quantity Sold
SELECT 
    SUM(od.quantity) AS total_quantity
FROM order_details od;


-- 4. Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(od.unit_price * od.quantity) AS revenue
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;


-- 5. Top 5 Customers by Revenue
SELECT 
    c.company_name,
    SUM(od.unit_price * od.quantity) AS revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_details od 
    ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY revenue DESC
LIMIT 5;


-- 6. Top 5 Products by Quantity Sold
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM products p
JOIN order_details od 
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;


-- 7. Sales by Country
SELECT 
    o.ship_country,
    SUM(od.unit_price * od.quantity) AS revenue
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
GROUP BY o.ship_country
ORDER BY revenue DESC;


-- 8. Average Order Value (Advanced 🔥)
SELECT 
    SUM(od.unit_price * od.quantity) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id;
