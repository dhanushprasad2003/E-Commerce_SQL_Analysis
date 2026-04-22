-- TOTAL NUMBER OF CUSTOMERS
SELECT COUNT(*) AS total_customers
FROM customers;

-- TOTAL NUMBER OF PRODUCTS
SELECT COUNT(*) AS total_products
FROM products;

-- ALL PRODUCT CATEGORIES
SELECT * FROM categories;

-- TOTAL REVENUE FROM ALL ORDERS
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- TOTAL NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders
FROM orders;

-- REVENUE PER CATEGORY
SELECT
c.category_name,
SUM(o.total_amount) AS category_revenue
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
INNER JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY category_revenue DESC;

-- TOTAL SPENDING PER CUSTOMER
SELECT
cu.first_name ||' '|| cu.last_name
AS customer_name,
SUM(o.total_amount) AS total_spent
FROM orders o
INNER JOIN customers cu
ON o.customer_id = cu.customer_id
GROUP BY cu.first_name, cu.last_name
ORDER BY total_spent DESC;

-- ORDER COUNT PER CUSTOMER
SELECT
cu.first_name ||' '|| cu.last_name
AS customer_name,
COUNT(*) AS order_count
FROM orders o
INNER JOIN customers cu
ON o.customer_id = cu.customer_id
GROUP BY cu.first_name, cu.last_name
ORDER BY order_count DESC;

-- TOP 5 BEST-SELLING PRODUCTS
SELECT
p.product_name,
SUM(o.quantity) AS total_qty_sold
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_qty_sold DESC
LIMIT 5;

-- REVENUE PER MONTH 
SELECT
TO_CHAR(order_date, 'YYYY-MM')
AS order_month,
SUM(total_amount) AS monthly_revenue,
COUNT(*) AS num_orders
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY order_month;

-- AVERAGE ORDER VALUE
SELECT ROUND(AVG(total_amount), 2)
AS avg_order_value
FROM orders;

-- CUSTOMER COUNT PER CITY
SELECT
city,
COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- LOW STOCK PRODUCTS 
SELECT
p.product_name,
c.category_name,
p.stock_quantity
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id
WHERE p.stock_quantity < 100
ORDER BY p.stock_quantity ASC;

-- PRODUCT COUNT PER CATEGORY
SELECT
c.category_name,
COUNT(*) AS product_count
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;

-- REVENUE BY CATEGORY AND MONTH
SELECT
c.category_name,
TO_CHAR(o.order_date, 'YYYY-MM')
AS order_month,
SUM(o.total_amount) AS revenue
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
INNER JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name,
TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY c.category_name, order_month;

-- HIGH-SPENDING CUSTOMERS (ABOVE 3000)
SELECT
cu.first_name ||' '|| cu.last_name
AS customer_name,
SUM(o.total_amount) AS total_spent
FROM orders o
INNER JOIN customers cu
ON o.customer_id = cu.customer_id
GROUP BY cu.first_name, cu.last_name
HAVING SUM(o.total_amount) > 3000
ORDER BY total_spent DESC;

-- PRICE RANGE PER CATEGORY
SELECT
c.category_name,
MAX(p.price) AS most_expensive,
MIN(p.price) AS cheapest,
ROUND(AVG(p.price), 2) AS avg_price
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_price DESC;

-- FULL ORDER DETAILS REPORT
SELECT
cu.first_name ||' '|| cu.last_name
AS customer_name,
p.product_name,
c.category_name,
o.quantity,
o.total_amount,
o.order_date
FROM orders o
INNER JOIN customers cu
ON o.customer_id = cu.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
INNER JOIN categories c
ON p.category_id = c.category_id
ORDER BY o.order_date DESC;

-- CUSTOMERS WITH NO ORDERS
SELECT
cu.first_name,
cu.last_name,
cu.email
FROM customers cu
LEFT JOIN orders o
ON cu.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- REPEAT CUSTOMERS (MORE THAN 2 ORDERS)
SELECT
cu.first_name ||' '|| cu.last_name
AS customer_name,
COUNT(*) AS order_count,
SUM(o.total_amount) AS total_spent
FROM orders o
INNER JOIN customers cu
ON o.customer_id = cu.customer_id
GROUP BY cu.first_name, cu.last_name
HAVING COUNT(*) > 2
ORDER BY order_count DESC;



