-- 05-analytics.sql
-- Аналитические запросы для проверки

-- 1. Проверка общего количества строк в таблице фактов
SELECT COUNT(*) AS total_sales_records 
FROM fact_sales;

-- 2. Проверка заполненности измерений
SELECT 'Customers' AS dimension, COUNT(*) AS cnt FROM dim_customer
UNION ALL
SELECT 'Products', COUNT(*) FROM dim_product
UNION ALL
SELECT 'Suppliers', COUNT(*) FROM dim_supplier
UNION ALL
SELECT 'Stores', COUNT(*) FROM dim_store;

-- 3. Топ-5 стран, приносящих наибольшую выручку
SELECT 
    ds.country AS store_country,
    SUM(fs.sale_total_price) AS total_revenue,
    SUM(fs.sale_quantity) AS total_items_sold
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id = ds.store_id
GROUP BY ds.country
ORDER BY total_revenue DESC
LIMIT 5;

-- 4. Продажи по категориям питомцев
SELECT 
    dp.pet_category,
    sup.name AS supplier_name,
    COUNT(fs.sale_id) AS number_of_sales,
    SUM(fs.sale_total_price) AS revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_supplier sup ON dp.supplier_id = sup.supplier_id
GROUP BY dp.pet_category, sup.name
ORDER BY revenue DESC
LIMIT 10;
