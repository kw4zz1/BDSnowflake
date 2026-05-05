-- 03-create-facts.sql
-- DDL Факт

CREATE TABLE IF NOT EXISTS fact_sales (
    sale_id SERIAL PRIMARY KEY,
    date_id INT REFERENCES dim_date(date_id),
    customer_id INT REFERENCES dim_customer(customer_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    product_id INT REFERENCES dim_product(product_id),
    store_id INT REFERENCES dim_store(store_id),
    sale_quantity INT,
    sale_total_price NUMERIC,
    product_price NUMERIC,
    inventory_quantity INT
);
